# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UndoTransaction
      #   Fineract::Api::Savings::UndoTransaction.undo(id: 1)
      #
      class UndoTransaction < AuthorisedBase
        post :undo, "/savingsaccounts/:id/transactions/:transactionId?command=undo", rubify_names: true
      end
    end
  end
end
