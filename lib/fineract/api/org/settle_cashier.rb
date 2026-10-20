# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::SettleCashier
      #   Fineract::Api::Org::SettleCashier.settle(id: 1)
      #
      class SettleCashier < AuthorisedBase
        post :settle, "/tellers/:id/cashiers/:cashierId/settle", rubify_names: true
      end
    end
  end
end
