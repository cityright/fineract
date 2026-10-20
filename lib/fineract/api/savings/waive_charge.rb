# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::WaiveCharge
      #   Fineract::Api::Savings::WaiveCharge.waive(id: 1)
      #
      class WaiveCharge < AuthorisedBase
        post :waive, "/savingsaccounts/:id/charges/:chargeId?command=waive", rubify_names: true
      end
    end
  end
end
