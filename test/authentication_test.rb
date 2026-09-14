# frozen_string_literal: true

require "test_helper"

class AuthenticationTest < Minitest::Test
  def test_supports_username_password_basic_authentication
    assert_authorization(Fineract::Authentication::Basic.new("jane", "secret"), "Basic amFuZTpzZWNyZXQ=")
  end

  def test_supports_pre_encoded_basic_key
    assert_authorization(Fineract::Authentication::BasicKey.new("amFuZTpzZWNyZXQ="), "Basic amFuZTpzZWNyZXQ=")
  end

  def test_supports_bearer_tokens
    assert_authorization(Fineract::Authentication::Bearer.new("token-123"), "Bearer token-123")
  end

  def test_supports_custom_strategy_and_preserves_tenant
    strategy = Class.new do
      def apply(request)
        request.headers["Authorization"] = "Custom value"
        request.headers["Fineract-Platform-TenantId"] = "wrong-tenant"
      end
    end.new
    assert_authorization(strategy, "Custom value", tenant: "right-tenant")
  end

  def test_shorthand_authentication_options
    assert_authorization(nil, "Basic amFuZTpzZWNyZXQ=", basic_key: "amFuZTpzZWNyZXQ=")
    assert_authorization(nil, "Bearer token-123", bearer_token: "token-123")
  end

  def test_rejects_conflicting_or_invalid_authentication
    assert_raises(Fineract::ConfigurationError) do
      Fineract.client(username: "jane", password: "secret", bearer_token: "token")
    end
    assert_raises(Fineract::ConfigurationError) { Fineract.client(authentication: Object.new) }
    assert_raises(Fineract::ConfigurationError) { Fineract.client(basic_key: "") }
  end

  private

  def assert_authorization(strategy, authorization, tenant: "tenant-a", **options)
    stubs = Faraday::Adapter::Test::Stubs.new do |routes|
      routes.get("/fineract-provider/api/v1/probe") do |env|
        assert_equal authorization, env.request_headers["Authorization"]
        assert_equal tenant, env.request_headers["Fineract-Platform-TenantId"]
        refute_includes env.url.query.to_s, "secret"
        [204, {}, ""]
      end
    end
    client = Fineract.client(adapter: [:test, stubs], tenant_id: tenant, authentication: strategy, **options)
    client.get("probe", query: { unrelated: "value" })
    stubs.verify_stubbed_calls
  end
end
