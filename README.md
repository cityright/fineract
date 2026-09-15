# Fineract

A framework-agnostic Ruby client for Apache Fineract.

The 1.0 line requires Ruby 3.2 or newer and does not depend on Rails. It can be
used from plain Ruby or any Ruby web framework.

For applications upgrading from the pre-1.0 Flexirest API, see the [breaking-change migration guide](docs/legacy-resource-mapping.md).

## Installation

Add the gem to your Gemfile:

```ruby
gem "fineract"
```

Then run `bundle install`.

## Configuration

Fineract never reads credentials or other settings from the environment on its
own. Configure global defaults explicitly:

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
```

Applications that connect to multiple servers or tenants can create isolated
clients. Explicit client options override global defaults and are copied when
the client is created:

```ruby
client = Fineract::Client.new(
  base_url: "https://another.example.com/fineract-provider/api",
  tenant_id: "another-tenant",
  username: ENV.fetch("ANOTHER_FINERACT_USERNAME"),
  password: ENV.fetch("ANOTHER_FINERACT_PASSWORD")
)
```

Invalid configuration raises `Fineract::ConfigurationError` immediately.
`base_url` is required, accepts only HTTP(S) URLs without embedded
credentials, and is normalized without trailing slashes.

### Settings

| Setting | Default | Description |
| --- | --- | --- |
| `base_url` | required | Fineract provider API root |
| `api_version` | `"v1"` | API version appended by endpoint requests |
| `tenant_id` | `"default"` | Fineract tenant identifier |
| `username` | `nil` | Basic authentication username |
| `password` | `nil` | Basic authentication password |
| `authentication` | `nil` | Optional custom authentication strategy |
| `timeout` | `10` | Read timeout in seconds |
| `open_timeout` | `5` | Connection timeout in seconds |
| `logger` | `nil` | Optional logger |
| `adapter` | `Faraday.default_adapter` | Faraday adapter |
| `retry_options` | conservative backoff | Options for idempotent-request retries |
| `verify_ssl` | `true` | Verify server TLS certificates |
| `user_agent` | gem name and version | HTTP User-Agent value |
| `locale` | `nil` | Optional default Fineract locale |
| `date_format` | `nil` | Optional default Fineract date format |

The default retry options are:

```ruby
{
  max: 2,
  interval: 0.1,
  interval_randomness: 0.5,
  backoff_factor: 2
}
```

## Development

Run `bin/setup` after cloning the repository. The default Rake task runs the
Minitest suite, RuboCop, generated-file freshness, and endpoint conformance:

```console
$ bundle exec rake
```

Regenerate the checked-in endpoint coverage artifact after changing an endpoint:

```console
$ bundle exec rake endpoints:report
```

### Integration tests

Integration tests are opt-in and target a dedicated Apache Fineract 1.15.0 test
deployment. Copy `.env.integration.example`, provide credentials, and export the
values before running files under `test/integration`. The gem never loads the
environment file itself.

Destructive integration tests require both `FINERACT_DESTRUCTIVE=1` and
`FINERACT_DEDICATED=1`. The test guard rejects shared demo hosts even when both
flags are set. Add this guard at the start of every destructive test:

```ruby
IntegrationConfiguration.allow_destructive!
```

## Contributing

Bug reports and pull requests are welcome at
https://github.com/cityright/fineract.

## License

The gem is available as open source under the terms of the MIT License.

## Authentication

Configure exactly one strategy. Username and password use HTTP Basic
authentication; `basic_key` accepts a pre-encoded Basic credential and
`bearer_token` accepts a token with or without the `Bearer` prefix:

```ruby
Fineract.client(basic_key: ENV.fetch("FINERACT_BASIC_KEY"))
Fineract.client(bearer_token: ENV.fetch("FINERACT_TOKEN"))
Fineract.client(username: "user", password: "secret")
```

Custom authentication objects only need `apply(request)`:

```ruby
class ApiKeyAuthentication
  def initialize(key) = @key = key
  def apply(request) = request.headers["X-Api-Key"] = @key
end

client = Fineract.client(authentication: ApiKeyAuthentication.new(ENV.fetch("FINERACT_API_KEY")))
```

## Resource calls

Resources are grouped under the client. Common calls include:

```ruby
client.clients.list(office_id: 1)
client.clients.create(office_id: 1, firstname: "Ada", lastname: "Lovelace", active: true)
client.clients.retrieve(42)
client.clients.update(42, mobile_no: "+254700000000")
client.clients.activate(42, activation_date: "2026-09-15")

client.groups.list
client.offices.retrieve(1)
client.loans.template(client_id: 42)
client.accounting.gl_accounts.list
client.reporting.runner.run("Client Portfolio", format: :csv)
```

The supported surface is exposed through `security`, `administration`,
`organization`, `clients`, `groups`, `centers`, `offices`, `loans`,
`loan_products`, `fixed_deposits`, `recurring_deposits`, `accounting`, `shares`,
`account_transfers`, `reporting`, `search`, `provisioning`, `taxes`,
`payment_types`, `floating_rates`, `rates`, and `interest_rate_charts`.

## Results and errors

Resource calls return `Fineract::Success` or `Fineract::Failure`. A success
contains a `Fineract::Response` with `status`, `headers`, `data`, `body`,
`success?`, and `request_id`. Failures contain typed errors:

- `ValidationError` for invalid local input or request data.
- `ApiError` for non-2xx responses; inspect `status`, `payload`,
  `parameter_errors`, and `developer_message`.
- `TransportError` for connection and timeout failures.
- `SerializationError` for invalid successful response data.
- `UnknownOperationError` for an unknown low-level operation.

```ruby
result = client.clients.retrieve(42)
if result.success?
  puts result.value!.data["displayName"]
else
  warn "Fineract failed: #{result.failure.message}"
end
```

Configuration errors are raised immediately. Sensitive values in errors and
logs are redacted.

## Low-level calls

Use `call` with an operation name from the 1.15.0 catalog when a resource helper
is not sufficient. It validates path, query, headers, and body inputs:

```ruby
result = client.call(:retrieve_one_client,
  path: { clientId: 42 },
  query: { staffInSelectedOfficeOnly: true })
```

For direct HTTP access, `request` and verb helpers accept transport options:

```ruby
client.get("clients/42", query: { associations: "loanAccounts" })
client.post("clients", body: { officeId: 1, firstname: "Ada" }, request_type: :json)
```

## Retries

Retries apply by default only to safe/idempotent `GET`, `PUT`, and `DELETE`
requests, plus requests explicitly marked idempotent or carrying an idempotency
key. Retryable statuses are 429, 500, 502, 503, and 504, as well as connection
and timeout failures. Configure the backoff as follows:

```ruby
Fineract.configure do |config|
  config.retry_options = { max: 3, interval: 0.25, backoff_factor: 2, interval_randomness: 0.25 }
end

client.post("payments", body: attributes, idempotent: true, idempotency_key: "payment-123")
```

## Uploads and downloads

Bulk template resources accept an IO-like object and send multipart form data.
Download methods return binary response data:

```ruby
File.open("groups.csv", "rb") do |file|
  client.groups.upload_template(uploaded_input_stream: file, locale: "en")
end

result = client.groups.download_template
File.binwrite("groups-template.csv", result.value!.data) if result.success?
```

The transport also supports `binary`, `text`, `csv`, and JSON bodies.

## Ruby and web frameworks

The client is framework agnostic. The same construction works in standalone
Ruby, Rails, Hanami, and generic Rack applications; no framework-specific
integration code is required:

```ruby
# Standalone Ruby
require "fineract"
client = Fineract.client(base_url: ENV.fetch("FINERACT_BASE_URL"))
```

```ruby
# Rails initializer or service object
require "fineract"
client = Fineract.client(base_url: Rails.application.config.x.fineract_base_url)
```

```ruby
# Hanami action or service
require "fineract"
