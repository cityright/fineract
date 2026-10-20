# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::UndoTransaction
      #   Fineract::Api::RecurringDeposits::UndoTransaction.undo(id: 1)
      #
      class UndoTransaction < AuthorisedBase
        post :undo, "/recurringdepositaccounts/:id/transactions/:transactionId?command=undo", rubify_names: true
      end
    end
  end
end
