# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateProductMix
      #   Fineract::Api::Org::UpdateProductMix.save(id: 1)
      #
      class UpdateProductMix < AuthorisedBase
        put :save, "/loanproducts/:id/productmix", rubify_names: true
      end
    end
  end
end
