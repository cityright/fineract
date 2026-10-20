# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::CreateSavingsProduct
      #   Fineract::Api::Products::CreateSavingsProduct.create()
      #
      class CreateSavingsProduct < AuthorisedBase
        post :create, "/savingsproducts", rubify_names: true
      end
    end
  end
end
