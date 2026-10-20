# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::CalculateInterest
      #   Fineract::Api::FixedDeposits::CalculateInterest.calculate(id: 1)
      #
      class CalculateInterest < AuthorisedBase
        post :calculate, "/fixeddepositaccounts/:id?command=calculateInterest", rubify_names: true
      end
    end
  end
end
