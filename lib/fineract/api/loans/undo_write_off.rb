# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::UndoWriteOff
      #   Fineract::Api::Loans::UndoWriteOff.undo_write_off(id: 1)
      #
      class UndoWriteOff < AuthorisedBase
        post :undo_write_off, "/loans/:id/transactions?command=undowriteoff", rubify_names: true
      end
    end
  end
end
