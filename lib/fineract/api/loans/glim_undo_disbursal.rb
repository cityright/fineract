# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GlimUndoDisbursal
      #   Fineract::Api::Loans::GlimUndoDisbursal.undo_disbursal(id: 1)
      #
      class GlimUndoDisbursal < AuthorisedBase
        post :undo_disbursal, "/loans/glimAccount/:id?command=undodisbursal", rubify_names: true
      end
    end
  end
end
