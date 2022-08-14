# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UpdateAddress
      #  params = {
      #    "id": 10,
      #    "addressTypeId":67,
      #     "street":"goldensource"
      #   }
      #   Fineract::Api::Client::UpdateAddress.save(params)
      #
      class UpdateAddress < AuthorisedBase
        before_request :format_create_params
        attr_accessor :address_type_id

        put :save, "/client/:id/addresses", rubify_names: true


        def format_create_params(name, request)
          binding.pry
          @address_type_id = 5
        end
      end
    end
  end
end
