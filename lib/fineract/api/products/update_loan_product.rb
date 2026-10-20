# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::UpdateLoanProduct
      #   Fineract::Api::Products::UpdateLoanProduct.save(id: 1)
      #
      class UpdateLoanProduct < AuthorisedBase
        put :save, "/loanproducts/:id", rubify_names: true
      end
    end
  end
end
