# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::Withdrawal
      #   Fineract::Api::RecurringDeposits::Withdrawal.withdraw(id: 1)
      #
      class Withdrawal < AuthorisedBase
        post :withdraw, "/recurringdepositaccounts/:id/transactions?command=withdrawal", rubify_names: true
      end
    end
  end
end
