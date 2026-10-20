# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetCashierTransactionTemplate
      #   Fineract::Api::Org::GetCashierTransactionTemplate.template(id: 1)
      #
      class GetCashierTransactionTemplate < AuthorisedBase
        get :template, "/tellers/:id/cashiers/:cashierId/transactions/template", rubify_names: true
      end
    end
  end
end
