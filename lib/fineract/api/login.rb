# frozen_string_literal: true

module Fineract
  module Api
    # Authentication model
    # @api public
    #
    class Login < Base
      post :create, "/authentication?username=:username&password=:password"
      verbose!

      before_request do |_name, request|
        request.headers["Fineract-Platform-TenantId"] = ENV["FINERACT_API_TENANT_ID"]
      end
    end
  end
end
