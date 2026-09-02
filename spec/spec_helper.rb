# frozen_string_literal: true

require "simplecov"
SimpleCov.start { skip "/spec/" }

require "bundler/setup"
require "fineract"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.expect_with(:rspec) { |expectations| expectations.syntax = :expect }

  config.before do
    Fineract.configure do |settings|
      settings.base_url = "https://fineract.example.com/fineract-provider/api"
      settings.api_version = "v1"
      settings.tenant_id = "default"
      settings.username = nil
      settings.password = nil
      settings.authentication = nil
      settings.timeout = 10
      settings.open_timeout = 5
      settings.logger = nil
      settings.adapter = Faraday.default_adapter
      settings.retry_options = Fineract::DEFAULT_RETRY_OPTIONS
      settings.verify_ssl = true
      settings.user_agent = "fineract-ruby/#{Fineract::VERSION}"
      settings.locale = nil
      settings.date_format = nil
    end
  end
end
