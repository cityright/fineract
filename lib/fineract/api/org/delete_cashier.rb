# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::DeleteCashier
      #   Fineract::Api::Org::DeleteCashier.remove(id: 1)
      #
      class DeleteCashier < AuthorisedBase
        delete :remove, "/tellers/:id/cashiers/:cashierId", rubify_names: true
      end
    end
  end
end
