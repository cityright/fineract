# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::UndoApproveAccount
      #   Fineract::Api::FixedDeposits::UndoApproveAccount.undo_approval(id: 1)
      #
      class UndoApproveAccount < AuthorisedBase
        post :undo_approval, "/fixeddepositaccounts/:id?command=undoApproval", rubify_names: true
      end
    end
  end
end
