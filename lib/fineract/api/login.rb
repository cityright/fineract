# frozen_string_literal: true

module Fineract
    module Api
      # Authentication model
      # @api public
      #
      class Login < Base
        # post :create, '/fineract-provider/api/oauth/token?grant_type=password'
        # post :create, "/authentication"
        post :create, "/authentication?username=#{ENV['FINERACT_API_USERNAME']}&password=#{ENV['FINERACT_API_PASSWORD']}"
        verbose!
  
        before_request do |_name, request|
        
        #   public_key  = Mpesa::Api::Auth::Keys.public
        #   private_key = Mpesa::Api::Auth::Keys.private
        #   token = Base64.strict_encode64("#{public_key}:#{private_key}")
        #   username =  Fineract::Api::Auth::Keys.username,
        #   password =  Fineract::Api::Auth::Keys.password,
        #   client_id =  Fineract::Api::Auth::Keys.client_id,
        #   client_secret = Fineract::Api::Auth::Keys.client_secret
  
        #  request.headers['Authorization'] = "Basic #{token}".strip
         request.headers['Fineract-Platform-TenantId'] = Fineract::Api::Auth::Keys.tenant_id
         
        end
      end
    end
  end
  