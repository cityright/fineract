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
