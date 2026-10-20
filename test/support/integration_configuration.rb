# frozen_string_literal: true

require "uri"

module IntegrationConfiguration
  TARGET_VERSION = "1.15.0"
  SHARED_DEMO_HOSTS = %w[demo.mifos.io localhost].freeze

  class Error < StandardError; end

  module_function

  def enabled?(environment = ENV)
    environment["FINERACT_INTEGRATION"] == "1"
  end

  def client_options(environment = ENV)
    validate_target!(environment)
    {
      base_url: fetch!(environment, "FINERACT_BASE_URL"),
      tenant_id: fetch_any!(environment, "FINERACT_TENANT_ID", "FINERACT_API_TENANT_ID"),
      username: fetch_any!(environment, "FINERACT_USERNAME", "FINERACT_API_USERNAME"),
      password: fetch_any!(environment, "FINERACT_PASSWORD", "FINERACT_API_PASSWORD")
    }
  end

  def allow_destructive!(environment = ENV)
    raise Error, "set FINERACT_DESTRUCTIVE=1 to run destructive integration tests" unless environment["FINERACT_DESTRUCTIVE"] == "1"
    raise Error, "destructive tests require a dedicated deployment" unless environment["FINERACT_DEDICATED"] == "1"

    host = URI.parse(fetch!(environment, "FINERACT_BASE_URL")).host.to_s.downcase
    raise Error, "destructive tests cannot run against a shared demo tenant" if SHARED_DEMO_HOSTS.include?(host) || host.start_with?("demo.")

    true
  rescue URI::InvalidURIError
    raise Error, "FINERACT_BASE_URL must be a valid URL"
  end

  def validate_target!(environment)
    raise Error, "set FINERACT_INTEGRATION=1 to opt in" unless enabled?(environment)
    return if environment["FINERACT_VERSION"] == TARGET_VERSION

    raise Error, "integration deployment must run Fineract #{TARGET_VERSION}"
  end

  def fetch_any!(environment, *names)
    names.each do |name|
      value = environment[name]
      return value unless value.nil? || value.empty?
    end

    raise Error, "#{names.join(" or ")} is required"
  end

  def fetch!(environment, name)
    value = environment[name]
    return value unless value.nil? || value.empty?

    raise Error, "#{name} is required"
  end
end
