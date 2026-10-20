# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetCashierSummary
      #   Fineract::Api::Org::GetCashierSummary.summary(id: 1)
      #
      class GetCashierSummary < AuthorisedBase
        get :summary, "/tellers/:id/cashiers/:cashierId/summaryandtransactions", rubify_names: true
      end
    end
  end
end
