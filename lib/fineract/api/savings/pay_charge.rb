# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::PayCharge
      #   Fineract::Api::Savings::PayCharge.pay(id: 1)
      #
      class PayCharge < AuthorisedBase
        post :pay, "/savingsaccounts/:id/charges/:chargeId?command=paycharge", rubify_names: true
      end
    end
  end
end
