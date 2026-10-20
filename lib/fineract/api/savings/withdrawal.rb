# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::Withdrawal
      #   Fineract::Api::Savings::Withdrawal.withdraw(id: 1)
      #
      class Withdrawal < AuthorisedBase
        post :withdraw, "/savingsaccounts/:id/transactions?command=withdrawal", rubify_names: true
      end
    end
  end
end
