# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::CalculatePrematureAmount
      #   Fineract::Api::FixedDeposits::CalculatePrematureAmount.calculate(id: 1)
      #
      class CalculatePrematureAmount < AuthorisedBase
        post :calculate, "/fixeddepositaccounts/:id?command=calculatePrematureAmount", rubify_names: true
      end
    end
  end
end
