# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::CreateRecurringDepositProduct
      #   Fineract::Api::Products::CreateRecurringDepositProduct.create()
      #
      class CreateRecurringDepositProduct < AuthorisedBase
        post :create, "/recurringdepositproducts", rubify_names: true
      end
    end
  end
end
