# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::DeleteFixedDepositProduct
      #   Fineract::Api::Products::DeleteFixedDepositProduct.remove(id: 1)
      #
      class DeleteFixedDepositProduct < AuthorisedBase
        delete :remove, "/fixeddepositproducts/:id", rubify_names: true
      end
    end
  end
end
