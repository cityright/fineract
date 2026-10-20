# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::ListFixedDepositProducts
      #   Fineract::Api::Products::ListFixedDepositProducts.all()
      #
      class ListFixedDepositProducts < AuthorisedBase
        get :all, "/fixeddepositproducts", rubify_names: true
      end
    end
  end
end
