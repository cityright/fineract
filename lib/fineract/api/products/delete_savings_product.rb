# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::DeleteSavingsProduct
      #   Fineract::Api::Products::DeleteSavingsProduct.remove(id: 1)
      #
      class DeleteSavingsProduct < AuthorisedBase
        delete :remove, "/savingsproducts/:id", rubify_names: true
      end
    end
  end
end
