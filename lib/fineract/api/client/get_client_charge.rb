# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::GetClientCharge
      #   Fineract::Api::Client::GetClientCharge.find(id: 1)
      #
      class GetClientCharge < AuthorisedBase
        get :find, "/clients/:id/charges/:chargeId", rubify_names: true
      end
    end
  end
end
