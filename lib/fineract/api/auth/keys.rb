# frozen_string_literal: true

module Fineract
  module Api
    module Auth
      # Returns the private and public keys from ENV
      # @api public
      #
      module Keys
        # Error raised when there are missing keys
        #
        MissingKeysError = Class.new(StandardError)

        class << self
          def username
            keys[:username] || raise_error(:username)
          end

          def password
            keys[:password] || raise_error(:password)
          end

          def client_id
            keys[:client_id] || raise_error(:client_id)
          end

          def client_secret
            keys[:client_secret] || raise_error(:client_secret)
          end

          def tenant_id
            keys[:tenant_id] || raise_error(:tenant_id)
          end

          private

          def keys
            RequestStore.store[:fineract_api_keys] || {}
          end

          def raise_error(subject)
            raise MissingKeysError, "Missing #{subject} key"
          end
        end
      end
    end
  end
end
