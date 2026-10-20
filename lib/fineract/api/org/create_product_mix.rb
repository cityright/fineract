# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateProductMix
      #   Fineract::Api::Org::CreateProductMix.create(id: 1)
      #
      class CreateProductMix < AuthorisedBase
        post :create, "/loanproducts/:id/productmix", rubify_names: true
      end
    end
  end
end
