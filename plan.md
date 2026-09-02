# Fineract Ruby 1.0 Reimplementation Plan

## Summary

Rebuild the gem as a framework-agnostic Ruby 3.2+ client using the architectural style demonstrated by [Lipwa](https://github.com/kamalogudah/lipwa): explicit configuration, a shared Faraday adapter, dry-rb contracts and result objects, and domain-oriented resource clients.

Use [Apache Fineract 1.15.0](https://github.com/apache/fineract/releases/tag/1.15.0) as the initial compatibility target. Pin its generated OpenAPI definition as the machine-readable contract; use the [legacy Mifos API documentation](https://demo.mifos.io/api-docs/apiLive.htm) to improve descriptions and identify deprecated or undocumented operations.

This is a breaking 1.0 rewrite. Remove Flexirest, Rails, Active Record, Active Support, RequestStore, Zeitwerk, and the old endpoint-class API.

## Architecture and Public API

- Use:
  - `dry-configurable` for gem-wide defaults.
  - `dry-types` and `dry-struct` for configuration, responses, errors, and endpoint metadata.
  - `dry-validation` for request contracts.
  - `dry-monads` for `Success` and `Failure`.
  - `dry-container` for the resource registry.
  - Faraday and `faraday-retry` for transport.
- Use explicit `require_relative` loading like Lipwa, with no framework hooks or Rails detection.
- Provide global defaults plus independently configurable clients:

```ruby
Fineract.configure do |config|
  config.base_url = "https://fineract.example.com/fineract-provider/api"
  config.tenant_id = "default"
  config.username = ENV.fetch("FINERACT_USERNAME")
  config.password = ENV.fetch("FINERACT_PASSWORD")
  config.timeout = 10
  config.open_timeout = 5
end

client = Fineract.client
# or
client = Fineract::Client.new(base_url: "...", tenant_id: "...", ...)
```

- Expose domain resources rather than one class per operation:

```ruby
client.clients.list(limit: 50)
client.clients.retrieve(client_id)
client.clients.create(firstname: "Jane", ...)
client.clients.activate(client_id, activation_date: Date.today)

client.loans.approve(loan_id, approved_on_date: Date.today)
client.savings_accounts.deposit(account_id, amount: 1_000, transaction_date: Date.today)
```

- Every operation returns:
  - `Success(Fineract::Response)` for successful HTTP responses.
  - `Failure(Fineract::ValidationError)` for invalid local input.
  - `Failure(Fineract::ApiError)` for Fineract error responses.
  - `Failure(Fineract::TransportError)` for timeouts and connection failures.
  - `Failure(Fineract::SerializationError)` for unusable response bodies.
- `Fineract::Response` contains `status`, `headers`, parsed `data`, raw body, and request/correlation ID when present.
- Preserve Fineract wire keys by default. Resource methods accept idiomatic snake-case keywords and explicitly map them to Fineract camel-case fields.
- Add a complete low-level escape hatch from the first release:

```ruby
client.call(
  :activate_client,
  path: { client_id: 123 },
  query: { command: "activate" },
  body: {...}
)
```

This ensures every pinned OpenAPI operation is callable before all hand-designed resource methods are complete.

## Configuration, Authentication, and Transport

Follow the [dry-rb configuration approach](https://hanakai.org/learn/dry/getting-started) without reading environment variables inside library code.

Configuration settings:

- `base_url`, required and normalized without a trailing slash.
- `api_version`, default `v1`.
- `tenant_id`, default `default`.
- `username` and `password`, or an explicit authentication strategy.
- `timeout`, default 10 seconds.
- `open_timeout`, default 5 seconds.
- `logger`, optional.
- `adapter`, default `Faraday.default_adapter`.
- `retry_options`, with conservative defaults.
- `verify_ssl`, default `true`.
- `user_agent`, including gem version.
- Optional default locale and date format.

Implement pluggable authentication strategies:

- HTTP Basic using username/password.
- Pre-encoded Basic authentication key.
- Bearer token for compatible deployments.
- Custom strategy responding to `apply(request)`.
- Never place credentials in URL query parameters.
- Apply `Fineract-Platform-TenantId` to every authenticated request.

The HTTP adapter must:

- Support GET, POST, PUT, PATCH, and DELETE.
- Handle JSON, form, multipart upload, binary download, text, CSV, and empty responses.
- Encode path and query parameters independently.
- Redact authorization, cookies, tokens, passwords, and API keys from logs.
- Raise configuration errors immediately but convert runtime HTTP outcomes to `Failure`.
- Retry connection failures, 429, and transient 5xx responses only for idempotent requests by default. Mutating financial operations must not be retried unless explicitly marked safe or supplied with an idempotency mechanism.
- Retain Fineract's structured error payload, HTTP status, globalisation codes, parameter errors, and developer message.

## OpenAPI Catalog and Endpoint Coverage

Commit a versioned snapshot such as `specifications/fineract-1.15.0.json`, including its upstream URL, Fineract version, retrieval date, and checksum.

Create a deterministic generator that:

- Reads the pinned OpenAPI 3 document.
- Extracts every path and HTTP operation.
- Records operation ID, method, path template, tags, path/query/header parameters, request media types, response media types, security, and deprecation status.
- Generates immutable endpoint definitions and a registry.
- Normalizes duplicate, missing, or unsuitable operation IDs through a checked-in override map.
- Never overwrites hand-written resource methods or contracts.
- Produces a coverage report listing:
  - OpenAPI operations.
  - Registered low-level operations.
  - Hand-designed resource methods.
  - Legacy-only endpoints.
  - Deprecated or unsupported operations.
- Fails CI if an OpenAPI operation disappears, changes signature unexpectedly, or lacks a low-level registry entry.

Generated validation should enforce required path/query/header fields and basic OpenAPI types. Hand-written `dry-validation` contracts should enforce richer business rules for curated resource methods. Do not infer financial rules that Fineract itself does not publish.

## Phased Resource Implementation

Each phase adds idiomatic resource methods, contracts, documentation, unit tests, and representative integration tests. The generated operation catalog makes all remaining endpoints accessible throughout the rollout.

1. Foundation and current parity
   - Configuration, authentication, HTTP adapter, errors, responses, endpoint registry, generator, and generic `call`.
   - Clients, client addresses, client lifecycle and transfers.
   - Groups and offices.
   - Replace the existing 35 Flexirest operations and verify equivalent Fineract requests.

2. Organization and administration
   - Staff, holidays, working days, currencies, funds, charges, codes and code values.
   - Users, roles, permissions, password preferences, two-factor configuration.
   - Global configuration, external services, cache, hooks, account-number formats.
   - Scheduler jobs, audits, maker-checker workflows, batch requests, and notifications.

3. Customer and group operations
   - Client templates, identifiers, images, charges, transactions, accounts, notes, documents, and datatables.
   - Groups, centers, roles, membership, collection sheets, transfers, and account overviews.
   - Entity-datatable checks and entity field configuration.

4. Lending
   - Loan products and product mixes.
   - Loan applications, lifecycle commands, schedules, disbursements, repayments, refunds, foreclosure, write-off, and recovery.
   - Loan charges, collateral, guarantors, rescheduling, term variations, delinquency, and amortization allocation.
   - GLIM/GSIM, credit bureau, origination, external asset ownership, post-dated checks, and working-capital loans where present in 1.15.0.

5. Deposits and shares
   - Savings products, accounts, transactions, charges, beneficiaries, and standing instructions.
   - Fixed-deposit products, accounts, and transactions.
   - Recurring-deposit products, accounts, and transactions.
   - Share products, accounts, charges, dividends, and lifecycle commands.
   - Account transfers and transfer templates.

6. Accounting, tax, and provisioning
   - General-ledger accounts, accounting rules, closures, journal entries, accruals, and financial-activity mappings.
   - Provisioning criteria and entries.
   - Tax components, tax groups, payment types, floating rates, interest-rate charts, and slabs.
   - Teller and cash-management operations.

7. Reporting and specialist APIs
   - Reports, run reports, report-mailing jobs, search, and advanced search.
   - Templates and user-generated documents.
   - Surveys/SPM and self-service APIs.
   - Any remaining operations from the pinned OpenAPI coverage report.
   - Explicitly classify legacy-only operations as implemented, deprecated, replaced, or intentionally unavailable.

## Testing and Acceptance Criteria

- Replace RSpec with Minitest to follow Lipwa's project style.
- Test configuration isolation so multiple clients can safely target different tenants or servers in the same process.
- Use Faraday's test adapter for transport, authentication, header, encoding, timeout, retry, logging-redaction, upload, and download tests.
- Contract tests must prove invalid input produces `Failure` without making a network call.
- Response tests must cover JSON, empty, binary, malformed, paginated, and structured Fineract error bodies.
- Generator tests must use small fixtures and verify stable output, name overrides, deprecated operations, commands, multipart bodies, and duplicate operation IDs.
- Endpoint conformance tests must assert that every operation in the pinned specification exists in the registry with the correct verb and path.
- Add opt-in integration tests against an Apache Fineract 1.15.0 test deployment. Never run destructive integration tests against a shared demo tenant.
- CI must test Ruby 3.2 and the latest supported stable Ruby, run tests and linting, verify generated files are current, and publish the endpoint coverage report.
- Release acceptance requires:
  - No runtime Rails or Active Support dependency.
  - No disabled TLS verification.
  - No credentials in request URLs or logs.
  - Every pinned OpenAPI operation callable through the low-level client.
  - Every operation in the current gem represented by a resource method.
  - Full resource coverage completed by the end of phase 7.
  - README examples for standalone Ruby, Rails, Hanami, and other Rack applications without framework-specific integration code.

## Migration and Release

- Release as version `1.0.0`; do not retain compatibility wrappers for the old `Fineract::Api::*` classes.
- Document mappings from every old class call to its new resource method.
- Remove obsolete dependencies and the Railtie.
- Replace placeholder gem metadata, README, changelog, and RBS signatures.
- Keep `plan.md` out of the packaged gem.
- Document how to refresh the pinned specification for a later Fineract release:
  1. Download and checksum the new OpenAPI document.
  2. Generate the endpoint catalog and diff report.
  3. Resolve naming and compatibility changes explicitly.
  4. Update resource contracts and tests.
  5. Run conformance and integration suites.
  6. Publish breaking changes according to semantic versioning.

## Assumptions

- Apache Fineract 1.15.0 is the initial authoritative API version.
- Legacy Mifos documentation is advisory, not authoritative when it conflicts with the pinned OpenAPI definition.
- Full coverage means immediate low-level access to every pinned operation and phased delivery of idiomatic resource methods.
- The library remains an HTTP client gem and does not include persistence, Rails generators, background jobs, or UI code.
- Ruby 3.2+ and a breaking 1.0 release are acceptable.
