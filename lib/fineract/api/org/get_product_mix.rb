# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetProductMix
      #   Fineract::Api::Org::GetProductMix.find(id: 1)
      #
      class GetProductMix < AuthorisedBase
        get :find, "/loanproducts/:id/productmix", rubify_names: true
      end
    end
  end
end
