# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::GetShareProduct
      #   Fineract::Api::Products::GetShareProduct.find(id: 1)
      #
      class GetShareProduct < AuthorisedBase
        get :find, "/shareproducts/:id", rubify_names: true
      end
    end
  end
end
