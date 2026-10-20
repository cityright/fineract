# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
module Fineract
  module Api
    module Auth
      # Set up Fineract::Api::Base configuration
      # @api private
      #
      class BaseConfiguration
        # Parent configuration error class
        BaseError = Class.new(StandardError)

        # Error raised when there are missing credentials
        MissingCredentialsError = Class.new(BaseError)
        # Error raised when the base URL is undefined
        MissingBaseUrlError = Class.new(BaseError)

        class << self
          def call(options = {})
            RequestStore.store[:fineract_api_keys] = {}

            configure_auth_keys(
              username: options[:username],
              password: options[:password],
              tenant_id: options[:tenant_id]
            )
          end

          # :reek:DuplicateMethodCall
          def configure_auth_keys(username:, password:, tenant_id:)
            raise MissingCredentialsError unless username && password && tenant_id

            RequestStore.store[:fineract_api_keys][:username] = username
            RequestStore.store[:fineract_api_keys][:password] = password
            RequestStore.store[:fineract_api_keys][:tenant_id] = tenant_id
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
