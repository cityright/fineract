# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::UndoDisbursal
      #   Fineract::Api::Loans::UndoDisbursal.undo_disbursal(id: 1)
      #
      class UndoDisbursal < AuthorisedBase
        post :undo_disbursal, "/loans/:id?command=undoDisbursal", rubify_names: true
      end
    end
  end
end
