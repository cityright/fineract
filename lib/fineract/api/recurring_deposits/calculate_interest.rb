# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::CalculateInterest
      #   Fineract::Api::RecurringDeposits::CalculateInterest.calculate(id: 1)
      #
      class CalculateInterest < AuthorisedBase
        post :calculate, "/recurringdepositaccounts/:id?command=calculateInterest", rubify_names: true
      end
    end
  end
end
