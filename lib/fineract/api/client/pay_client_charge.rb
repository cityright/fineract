# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::PayClientCharge
      #   Fineract::Api::Client::PayClientCharge.pay(id: 1)
      #
      class PayClientCharge < AuthorisedBase
        post :pay, "/clients/:id/charges/:chargeId?command=pay", rubify_names: true
      end
    end
  end
end
