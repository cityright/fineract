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
        put :save, "/client/:id/addresses", rubify_names: true
      end
    end
  end
end
