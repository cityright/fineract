# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::ListSavingsProducts
      #   Fineract::Api::Products::ListSavingsProducts.all()
      #
      class ListSavingsProducts < AuthorisedBase
        get :all, "/savingsproducts", rubify_names: true
      end
    end
  end
end
