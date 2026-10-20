# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::DeleteRecurringDepositProduct
      #   Fineract::Api::Products::DeleteRecurringDepositProduct.remove(id: 1)
      #
      class DeleteRecurringDepositProduct < AuthorisedBase
        delete :remove, "/recurringdepositproducts/:id", rubify_names: true
      end
    end
  end
end
