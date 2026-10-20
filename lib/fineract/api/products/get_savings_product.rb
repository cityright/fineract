# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::GetSavingsProduct
      #   Fineract::Api::Products::GetSavingsProduct.find(id: 1)
      #
      class GetSavingsProduct < AuthorisedBase
        get :find, "/savingsproducts/:id", rubify_names: true
      end
    end
  end
end
