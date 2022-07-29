# frozen_string_literal: true
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'bundler/setup'
require 'dotenv'
Dotenv.load('.env.test')

require 'active_support/testing/time_helpers'
require 'climate_control'
require 'factory_bot'
require 'faker'
require 'pry'
require 'request_store'
require 'webmock/rspec'
require_relative 'support/helpers'

require 'fineract'
# require_relative 'support/helpers'
# require_relative 'support/custom_nullified_database'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryBot::Syntax::Methods
  config.include Helpers

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end


  config.before do
    Fineract::Api::Auth::BaseConfiguration.call(
      username: 'Some Username',
      password: 'Some Password',
      client_id: 'Some Client ID',
      client_secret: 'Some Client Secret',
      tenant_id: 'Some Tenant ID'
    )
  end


  config.before(:each) do
    stub_request(:get, /localhost:8443/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: "stubbed response", headers: {})
  end
end
