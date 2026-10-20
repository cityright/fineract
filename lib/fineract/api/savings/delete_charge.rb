# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::DeleteCharge
      #   Fineract::Api::Savings::DeleteCharge.remove(id: 1)
      #
      class DeleteCharge < AuthorisedBase
        delete :remove, "/savingsaccounts/:id/charges/:chargeId", rubify_names: true
      end
    end
  end
end
