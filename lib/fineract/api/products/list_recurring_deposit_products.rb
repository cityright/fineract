# frozen_string_literal: true

module Fineract
  module Api
    module Products
      # @example Products::ListRecurringDepositProducts
      #   Fineract::Api::Products::ListRecurringDepositProducts.all()
      #
      class ListRecurringDepositProducts < AuthorisedBase
        get :all, "/recurringdepositproducts", rubify_names: true
      end
    end
  end
end
