# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::InactivateCharge
      #   Fineract::Api::Savings::InactivateCharge.inactivate(id: 1)
      #
      class InactivateCharge < AuthorisedBase
        post :inactivate, "/savingsaccounts/:id/charges/:chargeId?command=inactivate", rubify_names: true
      end
    end
  end
end
