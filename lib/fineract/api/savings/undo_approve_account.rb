# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UndoApproveAccount
      #   Fineract::Api::Savings::UndoApproveAccount.undo_approval(id: 1)
      #
      class UndoApproveAccount < AuthorisedBase
        post :undo_approval, "/savingsaccounts/:id?command=undoApproval", rubify_names: true
      end
    end
  end
end
