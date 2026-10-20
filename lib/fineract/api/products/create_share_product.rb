# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::CreateShareProduct
      #   Fineract::Api::Products::CreateShareProduct.create()
      #
      class CreateShareProduct < AuthorisedBase
        post :create, "/shareproducts", rubify_names: true
      end
    end
  end
end
