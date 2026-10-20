# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::WithdrawApplication
      #   Fineract::Api::Savings::WithdrawApplication.withdraw(id: 1)
      #
      class WithdrawApplication < AuthorisedBase
        post :withdraw, "/savingsaccounts/:id?command=withdraw", rubify_names: true
      end
    end
  end
end
