# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::CalculateInterest
      #   Fineract::Api::Savings::CalculateInterest.calculate(id: 1)
      #
      class CalculateInterest < AuthorisedBase
        post :calculate, "/savingsaccounts/:id?command=calculateInterest", rubify_names: true
      end
    end
  end
end
