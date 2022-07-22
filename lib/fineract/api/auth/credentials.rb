# frozen_string_literal: true

module Fineract
    module Api
      module Auth
        # Authenticates client by exchanging a private and public key for
        # an access token and associated metadata
        # @api private
        #
        class Credentials
          GRANT_TYPE = 'password'
  
          attr_reader :request_store
  
          def self.call
            new.call
          end
  
          def initialize(store = RequestStore)
            @request_store = store
          end
  
          def call
            credentials = request_store.store
            return renew if credentials.empty? || expired?

            credentials
          end
  
          def renew
            request_store.store[:fineract_api_auth] = {
            #   auth_key: login.access_token,
              auth_key: login.base64EncodedAuthenticationKey,
            #   expiry: login.expires_in.to_i,
              issued_at: Time.now.utc.to_i
            }
          end
  
          def expired?
            issued_at = fineract_api_auth[:issued_at]
            expiry = fineract_api_auth[:expires_in].to_i
  
            return true unless issued_at && expiry
  
            current_time = Time.now.utc.to_i
            (issued_at + expiry) <= current_time
          end
  
          private
  
          def fineract_api_auth
            request_store.store[:fineract_api_auth] || {}
          end
  
          def login
            @login ||= Api::Login.create
          end
        end
      end
    end
  end
  