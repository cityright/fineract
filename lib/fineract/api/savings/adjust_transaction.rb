# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::AdjustTransaction
      #   Fineract::Api::Savings::AdjustTransaction.adjust(id: 1)
      #
      class AdjustTransaction < AuthorisedBase
        post :adjust, "/savingsaccounts/:id/transactions/:transactionId?command=modify", rubify_names: true
      end
    end
  end
end
