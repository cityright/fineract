# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::UndoApproveAccount
      #   Fineract::Api::RecurringDeposits::UndoApproveAccount.undo_approval(id: 1)
      #
      class UndoApproveAccount < AuthorisedBase
        post :undo_approval, "/recurringdepositaccounts/:id?command=undoApproval", rubify_names: true
      end
    end
  end
end
