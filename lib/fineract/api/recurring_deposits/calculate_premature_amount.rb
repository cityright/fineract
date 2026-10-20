# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::CalculatePrematureAmount
      #   Fineract::Api::RecurringDeposits::CalculatePrematureAmount.calculate(id: 1)
      #
      class CalculatePrematureAmount < AuthorisedBase
        post :calculate, "/recurringdepositaccounts/:id?command=calculatePrematureAmount", rubify_names: true
      end
    end
  end
end
