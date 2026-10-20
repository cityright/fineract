# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::DeleteProductMix
      #   Fineract::Api::Org::DeleteProductMix.remove(id: 1)
      #
      class DeleteProductMix < AuthorisedBase
        delete :remove, "/loanproducts/:id/productmix", rubify_names: true
      end
    end
  end
end
