# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::GetTransaction
      #   Fineract::Api::RecurringDeposits::GetTransaction.find(id: 1)
      #
      class GetTransaction < AuthorisedBase
        get :find, "/recurringdepositaccounts/:id/transactions/:transactionId", rubify_names: true
      end
    end
  end
end
