# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::GetFixedDepositProduct
      #   Fineract::Api::Products::GetFixedDepositProduct.find(id: 1)
      #
      class GetFixedDepositProduct < AuthorisedBase
        get :find, "/fixeddepositproducts/:id", rubify_names: true
      end
    end
  end
end
