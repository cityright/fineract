# frozen_string_literal: true

require "test_helper"
require_relative "support/integration_configuration"

class IntegrationConfigurationTest < Minitest::Test
  def test_integration_is_opt_in_and_pinned_to_fineract_1_15
    refute IntegrationConfiguration.enabled?({})
    error = assert_raises(IntegrationConfiguration::Error) do
      IntegrationConfiguration.client_options("FINERACT_INTEGRATION" => "1", "FINERACT_VERSION" => "1.14.0")
    end
    assert_match(/1\.15\.0/, error.message)
  end

  def test_builds_options_for_the_dedicated_target
    options = IntegrationConfiguration.client_options(base_environment)
    assert_equal "https://fineract.test.example/api", options[:base_url]
    assert_equal "isolated-test", options[:tenant_id]
  end

  def test_destructive_tests_require_two_explicit_opt_ins
    environment = base_environment
    error = assert_raises(IntegrationConfiguration::Error) { IntegrationConfiguration.allow_destructive!(environment) }
    assert_match(/FINERACT_DESTRUCTIVE/, error.message)
    environment["FINERACT_DESTRUCTIVE"] = "1"
    error = assert_raises(IntegrationConfiguration::Error) { IntegrationConfiguration.allow_destructive!(environment) }
    assert_match(/dedicated deployment/, error.message)
  end

  def test_destructive_tests_reject_shared_demo_tenants
    environment = base_environment.merge(
      "FINERACT_BASE_URL" => "https://demo.mifos.io/api",
      "FINERACT_DESTRUCTIVE" => "1", "FINERACT_DEDICATED" => "1"
    )
    error = assert_raises(IntegrationConfiguration::Error) { IntegrationConfiguration.allow_destructive!(environment) }
    assert_match(/shared demo tenant/, error.message)
  end

  private

  def base_environment
    { "FINERACT_INTEGRATION" => "1", "FINERACT_VERSION" => "1.15.0",
      "FINERACT_BASE_URL" => "https://fineract.test.example/api", "FINERACT_TENANT_ID" => "isolated-test",
      "FINERACT_USERNAME" => "user", "FINERACT_PASSWORD" => "secret" }
  end
end
