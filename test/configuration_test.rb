# frozen_string_literal: true

require "test_helper"

class ConfigurationTest < Minitest::Test
  def test_normalizes_configuration_and_preserves_defaults
    Fineract.configure do |config|
      config.base_url = " https://example.test/api/// "
      config.timeout = 3
    end
    configuration = Fineract.client.configuration

    assert_equal "https://example.test/api", configuration.base_url
    assert_equal 3, configuration.timeout
    assert_equal "v1", configuration.api_version
    assert_equal "default", configuration.tenant_id
    assert configuration.verify_ssl
  end

  def test_restores_settings_after_invalid_global_configuration
    assert_raises(Fineract::ConfigurationError) do
      Fineract.configure { |config| config.verify_ssl = nil }
    end
    assert Fineract.config.verify_ssl
  end

  def test_multiple_clients_are_isolated_in_one_process
    first_stubs = tenant_stub("tenant-one")
    second_stubs = tenant_stub("tenant-two")
    first = Fineract.client(base_url: "https://one.example.test/api", tenant_id: "tenant-one",
                            adapter: [:test, first_stubs])
    second = Fineract.client(base_url: "https://two.example.test/api", tenant_id: "tenant-two",
                             adapter: [:test, second_stubs])

    Fineract.configure { |config| config.tenant_id = "changed-global" }
    first.get("probe")
    second.get("probe")

    assert_equal "https://one.example.test/api", first.configuration.base_url
    assert_equal "https://two.example.test/api", second.configuration.base_url
    assert_equal "changed-global", Fineract.client.configuration.tenant_id
    first_stubs.verify_stubbed_calls
    second_stubs.verify_stubbed_calls
  end

  def test_rejects_invalid_configuration
    error = assert_raises(Fineract::ConfigurationError) { Fineract.client(base_url: nil) }
    assert_equal "base_url is required", error.message
    error = assert_raises(Fineract::ConfigurationError) { Fineract.client(base_url: "ftp://example.test") }
    assert_match(/HTTP\(S\)/, error.message)
    error = assert_raises(Fineract::ConfigurationError) do
      Fineract.client(base_url: "https://user:secret@example.test")
    end
    assert_match(/embedded credentials/, error.message)
    error = assert_raises(Fineract::ConfigurationError) { Fineract.client(timeout: 0) }
    assert_match(/positive number/, error.message)
    error = assert_raises(Fineract::ConfigurationError) { Fineract.client(username: "jane") }
    assert_match(/provided together/, error.message)
  end

  def test_copies_retry_options_into_each_client
    options = { max: 4 }
    client = Fineract.client(retry_options: options)
    options[:max] = 9

    assert_equal({ max: 4 }, client.configuration.retry_options)
    assert_predicate client.configuration.retry_options, :frozen?
  end

  private

  def tenant_stub(tenant)
    Faraday::Adapter::Test::Stubs.new do |stubs|
      stubs.get("/api/v1/probe") do |env|
        assert_equal tenant, env.request_headers["Fineract-Platform-TenantId"]
        [204, {}, ""]
      end
    end
  end
end
