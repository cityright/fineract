# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::ListLoanProducts
      #   Fineract::Api::Products::ListLoanProducts.all()
      #
      class ListLoanProducts < AuthorisedBase
        get :all, "/loanproducts", rubify_names: true
      end
    end
  end
end
