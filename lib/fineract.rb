# frozen_string_literal: true

require "dry/configurable"
require "faraday"
require "json"

require_relative "fineract/version"
require_relative "fineract/error"
require_relative "fineract/result"
require_relative "fineract/authentication"
require_relative "fineract/configuration"
require_relative "fineract/response"
require_relative "fineract/transport"
require_relative "fineract/client"

# Public namespace for the Fineract Ruby client.
module Fineract
  extend Dry::Configurable

  DEFAULT_RETRY_OPTIONS = {
    max: 2,
    interval: 0.1,
    interval_randomness: 0.5,
    backoff_factor: 2
  }.freeze

  setting :base_url, default: nil
  setting :api_version, default: "v1"
  setting :tenant_id, default: "default"
  setting :username, default: nil
  setting :password, default: nil
  setting :basic_key, default: nil
  setting :bearer_token, default: nil
  setting :basic_key, default: nil
  setting :bearer_token, default: nil
  setting :authentication, default: nil
  setting :timeout, default: 10
  setting :open_timeout, default: 5
  setting :logger, default: nil
  setting :adapter, default: Faraday.default_adapter
  setting :retry_options, default: DEFAULT_RETRY_OPTIONS
  setting :verify_ssl, default: true
  setting :user_agent, default: "fineract-ruby/#{VERSION}"
  setting :locale, default: nil
  setting :date_format, default: nil

  class << self
    def configure
      previous = config.to_h
      super
      Configuration.new(config.to_h)
      config
    rescue StandardError
      restore_config(previous) if previous
      raise
    end

    def client(**options)
      Client.new(**options)
    end

    private

    def restore_config(values)
      values.each { |name, value| config.public_send("#{name}=", value) }
    end
  end
end
