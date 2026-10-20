# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::Deposit
      #   Fineract::Api::Savings::Deposit.deposit(id: 1)
      #
      class Deposit < AuthorisedBase
        post :deposit, "/savingsaccounts/:id/transactions?command=deposit", rubify_names: true
      end
    end
  end
end
