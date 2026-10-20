# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UndoClientTransaction
      #   Fineract::Api::Client::UndoClientTransaction.undo(id: 1)
      #
      class UndoClientTransaction < AuthorisedBase
        post :undo, "/clients/:id/transactions/:transactionId?command=undo", rubify_names: true
      end
    end
  end
end
