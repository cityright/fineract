# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::CreateLoanProduct
      #   Fineract::Api::Products::CreateLoanProduct.create()
      #
      class CreateLoanProduct < AuthorisedBase
        post :create, "/loanproducts", rubify_names: true
      end
    end
  end
end
