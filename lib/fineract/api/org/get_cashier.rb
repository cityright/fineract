# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetCashier
      #   Fineract::Api::Org::GetCashier.find(id: 1)
      #
      class GetCashier < AuthorisedBase
        get :find, "/tellers/:id/cashiers/:cashierId", rubify_names: true
      end
    end
  end
end
