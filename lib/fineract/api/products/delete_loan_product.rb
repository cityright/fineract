# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::DeleteLoanProduct
      #   Fineract::Api::Products::DeleteLoanProduct.remove(id: 1)
      #
      class DeleteLoanProduct < AuthorisedBase
        delete :remove, "/loanproducts/:id", rubify_names: true
      end
    end
  end
end
