# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::UpdateFixedDepositProduct
      #   Fineract::Api::Products::UpdateFixedDepositProduct.save(id: 1)
      #
      class UpdateFixedDepositProduct < AuthorisedBase
        put :save, "/fixeddepositproducts/:id", rubify_names: true
      end
    end
  end
end
