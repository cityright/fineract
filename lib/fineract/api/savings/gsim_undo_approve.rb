# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimUndoApprove
      #   Fineract::Api::Savings::GsimUndoApprove.undo_approval(id: 1)
      #
      class GsimUndoApprove < AuthorisedBase
        post :undo_approval, "/savingsaccounts/gsimcommands/:id?command=undoapproval", rubify_names: true
      end
    end
  end
end
