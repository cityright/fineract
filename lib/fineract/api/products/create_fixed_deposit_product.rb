# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::CreateFixedDepositProduct
      #   Fineract::Api::Products::CreateFixedDepositProduct.create()
      #
      class CreateFixedDepositProduct < AuthorisedBase
        post :create, "/fixeddepositproducts", rubify_names: true
      end
    end
  end
end
