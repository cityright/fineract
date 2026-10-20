# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::WaiveClientCharge
      #   Fineract::Api::Client::WaiveClientCharge.waive(id: 1)
      #
      class WaiveClientCharge < AuthorisedBase
        post :waive, "/clients/:id/charges/:chargeId?command=waive", rubify_names: true
      end
    end
  end
end
