# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::WithdrawApplication
      #   Fineract::Api::RecurringDeposits::WithdrawApplication.withdraw(id: 1)
      #
      class WithdrawApplication < AuthorisedBase
        post :withdraw, "/recurringdepositaccounts/:id?command=withdraw", rubify_names: true
      end
    end
  end
end
