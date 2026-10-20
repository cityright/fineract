# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::UpdateRecurringDepositProduct
      #   Fineract::Api::Products::UpdateRecurringDepositProduct.save(id: 1)
      #
      class UpdateRecurringDepositProduct < AuthorisedBase
        put :save, "/recurringdepositproducts/:id", rubify_names: true
      end
    end
  end
end
