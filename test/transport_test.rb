# frozen_string_literal: true

require "logger"
require "stringio"
require "test_helper"

class TransportTest < Minitest::Test
  def client_with(stubs, **options)
    Fineract.client(**{
      adapter: [:test, stubs],
      retry_options: { max: 2, interval: 0, interval_randomness: 0, backoff_factor: 1 }
    }.merge(options))
  end

  def test_applies_isolated_headers_to_requests
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/widgets") do |env|
      assert_equal "tenant-a", env.request_headers["Fineract-Platform-TenantId"]
      assert_equal "transport-test", env.request_headers["User-Agent"]
      [204, {}, ""]
    end
    client = client_with(stubs, user_agent: "transport-test", tenant_id: "tenant-a")
    assert_equal 204, client.get("widgets").status
    stubs.verify_stubbed_calls
  end

  def test_encodes_and_decodes_json
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/payments") do |env|
      assert_equal "application/json", env.request_headers["Content-Type"]
      assert_equal '{"amount":10}', env.body
      [200, { "Content-Type" => "application/json" }, '{"id":1}']
    end
    response = client_with(stubs).post("payments", body: { amount: 10 })
    assert_equal({ "id" => 1 }, response.data)
    stubs.verify_stubbed_calls
  end

  def test_does_not_retry_mutations_by_default
    stubs = Faraday::Adapter::Test::Stubs.new
    attempts = 0
    stubs.post("/fineract-provider/api/v1/loans/1/transactions") do
      attempts += 1
      [503, {}, "busy"]
    end
    client = client_with(stubs)
    assert_equal 503, client.post("loans/1/transactions").status
    assert_equal 1, attempts
    stubs.verify_stubbed_calls
  end

  def test_rejects_sensitive_query_values_before_a_request_is_made
    output = StringIO.new
    client = client_with(Faraday::Adapter::Test::Stubs.new, logger: Logger.new(output))

    result = client.get("private", query: { access_token: "token-secret" })

    assert result.failure?
    assert_match(/must not be sent in a URL query/, result.failure.message)
    assert_empty output.string
  end

  def test_redacts_credentials_and_secrets_from_logs
    output = StringIO.new
    logger = Logger.new(output)
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/private") { [204, {}, ""] }
    client_with(stubs, username: "user", password: "secret", logger: logger).get(
      "private", query: { page: 1 }, headers: { "Cookie" => "session-secret", "X-Api-Key" => "key-secret" }
    )
    assert_includes output.string, "[REDACTED]"
    refute_includes output.string, "secret"
  end
end
