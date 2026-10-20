# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::ListShareProducts
      #   Fineract::Api::Products::ListShareProducts.all()
      #
      class ListShareProducts < AuthorisedBase
        get :all, "/shareproducts", rubify_names: true
      end
    end
  end
end
