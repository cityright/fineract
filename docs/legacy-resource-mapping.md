# Migrating from the pre-1.0 Flexirest API

This guide is for applications that used the pre-1.0 `Fineract::Api::*` classes. The 1.0 API is resource-oriented: create a `Fineract::Client` and call methods on the resource it exposes.

```ruby
client = Fineract.client
client.clients.list
client.loans.retrieve(loan_id)
```

The old classes are not compatibility aliases. `Fineract::Api::*` wrappers are intentionally unavailable in 1.0; update call sites to the resource methods below.


The old Flexirest classes map to the phase-one resource surface below. All
resource methods use the pinned OpenAPI operation catalog, so the HTTP verb,
path, query command, and request body remain request-compatible.

| Legacy call | Replacement |
| --- | --- |
| `Client::ListClients.all` | `client.clients.list` |
| `Client::CreateClient.create` | `client.clients.create` |
| `Client::GetClient.find` | `client.clients.retrieve(id)` |
| `Client::UpdateClient.save` | `client.clients.update(id, ...)` |
| `Client::DeleteClient.remove` | `client.clients.delete(id)` |
| `Client::ListClientAddress.all` | `client.clients.addresses.list(id)` |
| `Client::CreateAddress.create` | `client.clients.addresses.create(id, ...)` |
| `Client::UpdateAddress.save` | `client.clients.addresses.update(id, ...)` |
| `Client::RetrieveClientAccounts.find` | `client.clients.accounts(id)` |
| `Client::EntityFieldConfiguration.find` | `client.clients.field_configuration(entity)` |
| `Client::ActivateClient.create` | `client.clients.lifecycle.activate(id, ...)` |
| `Client::CloseClient.create` | `client.clients.lifecycle.close(id, ...)` |
| `Client::ReactivateClient.create` | `client.clients.lifecycle.reactivate(id, ...)` |
| `Client::RejectClient.create` | `client.clients.lifecycle.reject(id, ...)` |
| `Client::WithdrawClient.create` | `client.clients.lifecycle.withdraw(id, ...)` |
| `Client::UndoRejectClient.create` | `client.clients.lifecycle.undo_reject(id, ...)` |
| `Client::UndoWithdrawClient.create` | `client.clients.lifecycle.undo_withdraw(id, ...)` |
| `Client::AssignStaff.create` | `client.clients.assign_staff(id, staff_id: ...)` |
| `Client::UnassignStaff.create` | `client.clients.unassign_staff(id, staff_id: ...)` |
| `Client::UpdateSavingsAccount.save` | `client.clients.update_savings_account(id, savings_account_id: ...)` |
| `Client::ProposeTransfer.create` | `client.clients.transfers.propose_transfer(id, ...)` |
| `Client::AcceptTransfer.create` | `client.clients.transfers.accept_transfer(id, ...)` |
| `Client::RejectTransfer.create` | `client.clients.transfers.reject_transfer(id, ...)` |
| `Client::WithdrawTransfer.create` | `client.clients.transfers.withdraw_transfer(id, ...)` |
| `Client::ProposeAndAcceptTransfer.create` | `client.clients.transfers.propose_and_accept_transfer(id, ...)` |
| `Groups::ListGroups.all` | `client.groups.list` |
| `Groups::CreateGroup.create` | `client.groups.create` |
| `Groups::RetrieveGroup.find` | `client.groups.retrieve(id)` |
| `Groups::UpdateGroup.save` | `client.groups.update(id, ...)` |
| `Groups::DeleteGroup.remove` | `client.groups.delete(id)` |
| `Groups::RetrieveGroupTemplate.get` | `client.groups.template` |
| `Org::ListOffices.all` | `client.offices.list` |
| `Org::CreateOffice.create` | `client.offices.create` |
| `Org::RetrieveOffice.find` | `client.offices.retrieve(id)` |
| `Org::UpdateOffice.save` | `client.offices.update(id, ...)` |

The legacy login and authentication configuration classes are replaced by
`Fineract.configure`, `Fineract.client`, and the configured authentication
strategy; they are not resource endpoint operations.

## Loan servicing coverage

Loan servicing is available from `client.loans`:

| Capability | Resource methods |
| --- | --- |
| Schedules | `schedules.command`, `schedules.generate`, `schedules.reschedule` |
| Transactions | `transactions.list`, `create`, `disburse`, `repay`, `refund`, `foreclosure`, `write_off`, `recover`, `adjust` |
| Charges | `charges.list`, `create`, `pay`, `retrieve`, `update`, `delete` |
| Disbursements | `disbursements.update`, `retrieve`, `update_date` |
| Rescheduling and term variation | `reschedule`, `vary_term` |
| Delinquency | `delinquency.list`, `create`, `tags` |
| Amortization allocation | `transactions.re_amortize_preview`, `transactions.re_age_preview` |

## Accounting coverage

Primary accounting APIs are available from `client.accounting`:

| Capability | Resource methods |
| --- | --- |
| General-ledger accounts | `gl_accounts.list`, `create`, `retrieve`, `update`, `delete`, `template` |
| Accounting rules | `rules.list`, `create`, `retrieve`, `update`, `delete`, `template` |
| GL closures | `closures.list`, `create`, `retrieve`, `update`, `delete` |
| Journal entries | `journal_entries.list`, `create`, `retrieve`, `reverse`, `opening_balance`, `provisioning` |
| Accruals | `accruals.run` |
| Financial-activity mappings | `financial_activity_mappings.list`, `create`, `retrieve`, `update`, `delete` |

## Loan origination coverage

| Capability | Resource methods |
| --- | --- |
| Loan products | `client.loan_products.list`, `basic_details`, `create`, `retrieve`, `update`, `template` |
| Product mixes | `client.loan_products.product_mixes.retrieve`, `create`, `update`, `delete` |
| Applications | `client.loans.create`, `submit`, `calculate`, `retrieve`, `update`, `template` |
| Application lifecycle | `client.loans.approve`, `reject`, `withdraw`, `disburse`, `approval_template` |

## Share and transfer coverage

| Capability | Resource methods |
| --- | --- |
| Share products | `client.shares.products.list`, `create`, `retrieve`, `update`, `template`, `command` |
| Share accounts | `client.shares.accounts.list`, `create`, `retrieve`, `update`, `template`, `command`, `approve`, `activate`, `close` |
| Share dividends | `client.shares.dividends.list`, `create`, `retrieve`, `update`, `delete` |
| Account transfers | `client.account_transfers.list`, `create`, `retrieve`, `command`, `refund` |
| Transfer templates | `client.account_transfers.template`, `refund_template` |

## Reporting and discovery coverage

| Capability | Resource methods |
| --- | --- |
| Reports | `client.reporting.reports.list`, `create`, `retrieve`, `update`, `delete`, `template` |
| Run reports | `client.reporting.runner.run(name, format: :json/:csv/:pdf/:xls/:html)`, `available_exports` |
| Report mailing jobs | `client.reporting.mailing_jobs.list`, `create`, `retrieve`, `update`, `delete`, `template`, `run_history` |
| Search | `client.search.query`, `advanced`, `template` |

## Results and errors

Every resource operation returns `Fineract::Success` or `Fineract::Failure`.
A success contains a `Fineract::Response` (`status`, `headers`, `data`, and
`body`). A failure contains a typed error:

| Situation | Failure value |
| --- | --- |
| Invalid local argument, ID, or request body | `Fineract::ValidationError` |
| Non-2xx Fineract response | `Fineract::ApiError` (`status`, `payload`, `parameter_errors`, `developer_message`) |
| Timeout or connection failure | `Fineract::TransportError` (`cause`) |
| Response decoding failure | `Fineract::SerializationError` (`body`, `cause`) |
| Unknown operation passed to `client.call` | `Fineract::UnknownOperationError` |

Handle the result explicitly:

```ruby
result = client.clients.retrieve(42)

if result.success?
  puts result.value!.data["displayName"]
else
  error = result.failure
  warn "Fineract failed (#{error.class}): #{error.message}"
end
```

HTTP and transport failures are values, not exceptions, for ordinary resource
calls. `ConfigurationError` is different: invalid client configuration is
raised immediately when the client is constructed.

## Configuration and authentication

The old API read `FINERACT_BASE_URL` and authentication values indirectly and
used `Fineract::Api::Auth::BaseConfiguration`, `Keys`, `Credentials`, and
`Login`. The new API does not read environment variables on its own. Configure
the client explicitly:

```ruby
Fineract.configure do |config|
  config.base_url = "https://fineract.example.com/fineract-provider/api"
  config.tenant_id = "default"
  config.username = ENV.fetch("FINERACT_USERNAME")
  config.password = ENV.fetch("FINERACT_PASSWORD")
end

client = Fineract.client
```

`base_url` is the provider API root; `api_version` (default `"v1"`) is
appended by the client. The tenant is sent as `Fineract-Platform-TenantId`.

For an already-issued token or pre-encoded Basic credential, use one explicit
strategy. Only one authentication strategy may be configured:

```ruby
client = Fineract.client(
  base_url: "https://fineract.example.com/fineract-provider/api",
  tenant_id: "default",
  bearer_token: ENV.fetch("FINERACT_TOKEN")
)
# Or: basic_key: ENV.fetch("FINERACT_BASIC_KEY")
```

A custom scheme can be passed as an object responding to `apply(request)` via
`authentication`. `Fineract::Api::Login.create` has no 1.0 wrapper; use the
server's issued token, credentials, or a custom authentication strategy.
`Base` and `AuthorisedBase` were Flexirest implementation classes, not
resource operations, and have no replacement to subclass.

## Common before/after changes

```ruby
# Before
Fineract::Api::Client::ListClients.all
Fineract::Api::Client::CreateClient.create(
  "firstname" => "Jane", "lastname" => "Doe", "officeId" => 1
)

# After: resource methods use snake_case Ruby keywords and return a Result
result = client.clients.list
result = client.clients.create(firstname: "Jane", lastname: "Doe", office_id: 1)
```

```ruby
# Before: the ID was part of the Flexirest parameter hash
Fineract::Api::Groups::UpdateGroup.save("id" => 7, "name" => "New name")

# After: the ID is a positional resource argument
client.groups.update(7, name: "New name")
```

```ruby
# Before
Fineract::Api::Client::ActivateClient.create(
  id: 42, "activationDate" => "15 September 2026"
)

# After
result = client.clients.lifecycle.activate(42, activation_date: "15 September 2026")
result.success? ? result.value!.status : result.failure.message
```

## Behavioral differences to check during migration

* There is no dynamic Flexirest class API, `save`/`remove` convention, or
  compatibility wrapper. Resource names and operations are ordinary Ruby
  methods.
* Request keys are normally snake_case Ruby keywords; resources translate them
  to camelCase wire keys. Response data remains the decoded Fineract payload.
* IDs are validated locally as positive integers. Invalid input produces a
  `Failure(ValidationError)` without an HTTP request.
* Non-2xx responses, transport failures, and serialization failures are typed
  `Failure` values. Inspect `ApiError.payload` and `ApiError.parameter_errors`
  for Fineract details.
* Safe/idempotent requests can be retried according to `retry_options`; mutations
  are not retried by default.
* Configuration is explicit and validated. Credentials must not be embedded in
  `base_url`, and a client cannot combine authentication strategies.
