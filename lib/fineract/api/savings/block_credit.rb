# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::BlockCredit
      #   Fineract::Api::Savings::BlockCredit.block_credit(id: 1)
      #
      class BlockCredit < AuthorisedBase
        post :block_credit, "/savingsaccounts/:id?command=blockCredit", rubify_names: true
      end
    end
  end
end
