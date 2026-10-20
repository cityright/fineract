# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateCashier
      #   Fineract::Api::Org::UpdateCashier.save(id: 1)
      #
      class UpdateCashier < AuthorisedBase
        put :save, "/tellers/:id/cashiers/:cashierId", rubify_names: true
      end
    end
  end
end
