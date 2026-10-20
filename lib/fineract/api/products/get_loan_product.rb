# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::GetLoanProduct
      #   Fineract::Api::Products::GetLoanProduct.find(id: 1)
      #
      class GetLoanProduct < AuthorisedBase
        get :find, "/loanproducts/:id", rubify_names: true
      end
    end
  end
end
