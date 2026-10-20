# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::DeleteShareProduct
      #   Fineract::Api::Products::DeleteShareProduct.remove(id: 1)
      #
      class DeleteShareProduct < AuthorisedBase
        delete :remove, "/shareproducts/:id", rubify_names: true
      end
    end
  end
end
