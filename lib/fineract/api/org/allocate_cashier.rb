# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::AllocateCashier
      #   Fineract::Api::Org::AllocateCashier.allocate(id: 1)
      #
      class AllocateCashier < AuthorisedBase
        post :allocate, "/tellers/:id/cashiers/:cashierId/allocate", rubify_names: true
      end
    end
  end
end
