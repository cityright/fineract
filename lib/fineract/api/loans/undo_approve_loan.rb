# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::UndoApproveLoan
      #   Fineract::Api::Loans::UndoApproveLoan.undo_approval(id: 1)
      #
      class UndoApproveLoan < AuthorisedBase
        post :undo_approval, "/loans/:id?command=undoApproval", rubify_names: true
      end
    end
  end
end
