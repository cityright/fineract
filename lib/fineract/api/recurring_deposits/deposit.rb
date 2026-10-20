# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::Deposit
      #   Fineract::Api::RecurringDeposits::Deposit.deposit(id: 1)
      #
      class Deposit < AuthorisedBase
        post :deposit, "/recurringdepositaccounts/:id/transactions?command=deposit", rubify_names: true
      end
    end
  end
end
