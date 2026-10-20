# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::UndoApproveAccount
      #   Fineract::Api::Shares::UndoApproveAccount.undo_approval(id: 1)
      #
      class UndoApproveAccount < AuthorisedBase
        post :undo_approval, "/accounts/share/:id?command=undoApproval", rubify_names: true
      end
    end
  end
end
