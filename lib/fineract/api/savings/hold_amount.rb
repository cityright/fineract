# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::HoldAmount
      #   Fineract::Api::Savings::HoldAmount.hold(id: 1)
      #
      class HoldAmount < AuthorisedBase
        post :hold, "/savingsaccounts/:id/transactions/:transactionId?command=holdAmount", rubify_names: true
      end
    end
  end
end
