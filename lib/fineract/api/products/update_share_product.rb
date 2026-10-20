# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::UpdateShareProduct
      #   Fineract::Api::Products::UpdateShareProduct.save(id: 1)
      #
      class UpdateShareProduct < AuthorisedBase
        put :save, "/shareproducts/:id", rubify_names: true
      end
    end
  end
end
