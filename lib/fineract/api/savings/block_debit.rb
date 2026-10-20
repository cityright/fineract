# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::BlockDebit
      #   Fineract::Api::Savings::BlockDebit.block_debit(id: 1)
      #
      class BlockDebit < AuthorisedBase
        post :block_debit, "/savingsaccounts/:id?command=blockDebit", rubify_names: true
      end
    end
  end
end
