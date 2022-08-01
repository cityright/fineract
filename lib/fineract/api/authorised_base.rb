# frozen_string_literal: true

module Fineract
  module Api
    # Configures authorisation param `access_token` with a valid access token
    # @abstract
    #
    class AuthorisedBase < Base
      before_request do |_name, request|
        credentials = Api::Auth::Credentials.call
        access_token = credentials[:auth_key]

        request.headers["Authorization"] = "Basic #{access_token}"
        request.headers["Fineract-Platform-TenantId"] = ENV["FINERACT_API_TENANT_ID"]
      end
    end
  end
end
