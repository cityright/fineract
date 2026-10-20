# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::GetRecurringDepositProduct
      #   Fineract::Api::Products::GetRecurringDepositProduct.find(id: 1)
      #
      class GetRecurringDepositProduct < AuthorisedBase
        get :find, "/recurringdepositproducts/:id", rubify_names: true
      end
    end
  end
end
