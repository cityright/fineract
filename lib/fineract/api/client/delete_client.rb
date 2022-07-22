
# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client::GetClient
        #   Fineract::Api::Client::GetClient.find(id)
        # 
        #
        class DeleteClient < AuthorisedBase
          before_request :camelize_params
  
          delete :remove, '/clients/:id', rubify_names: true

        end
      end
    end
  end
  