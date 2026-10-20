# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UnblockDebit
      #   Fineract::Api::Savings::UnblockDebit.unblock_debit(id: 1)
      #
      class UnblockDebit < AuthorisedBase
        post :unblock_debit, "/savingsaccounts/:id?command=unblockDebit", rubify_names: true
      end
    end
  end
end
