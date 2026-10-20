# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GlimUndoApprove
      #   Fineract::Api::Loans::GlimUndoApprove.undo_approval(id: 1)
      #
      class GlimUndoApprove < AuthorisedBase
        post :undo_approval, "/loans/glimAccount/:id?command=undoapproval", rubify_names: true
      end
    end
  end
end
