# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListCashierTransactions
      #   Fineract::Api::Org::ListCashierTransactions.all(id: 1)
      #
      class ListCashierTransactions < AuthorisedBase
        get :all, "/tellers/:id/cashiers/:cashierId/transactions", rubify_names: true
      end
    end
  end
end
