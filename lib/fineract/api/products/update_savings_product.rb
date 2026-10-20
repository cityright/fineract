# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::UpdateSavingsProduct
      #   Fineract::Api::Products::UpdateSavingsProduct.save(id: 1)
      #
      class UpdateSavingsProduct < AuthorisedBase
        put :save, "/savingsproducts/:id", rubify_names: true
      end
    end
  end
end
