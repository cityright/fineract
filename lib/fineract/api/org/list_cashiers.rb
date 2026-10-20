# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListCashiers
      #   Fineract::Api::Org::ListCashiers.all(id: 1)
      #
      class ListCashiers < AuthorisedBase
        get :all, "/tellers/:id/cashiers", rubify_names: true
      end
    end
  end
end
