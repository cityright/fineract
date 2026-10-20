# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GetCharge
      #   Fineract::Api::Savings::GetCharge.find(id: 1)
      #
      class GetCharge < AuthorisedBase
        get :find, "/savingsaccounts/:id/charges/:chargeId", rubify_names: true
      end
    end
  end
end
