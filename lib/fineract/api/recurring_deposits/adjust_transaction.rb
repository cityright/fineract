# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::AdjustTransaction
      #   Fineract::Api::RecurringDeposits::AdjustTransaction.adjust(id: 1)
      #
      class AdjustTransaction < AuthorisedBase
        post :adjust, "/recurringdepositaccounts/:id/transactions/:transactionId?command=modify", rubify_names: true
      end
    end
  end
end
