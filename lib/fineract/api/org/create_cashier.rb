# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateCashier
      #   Fineract::Api::Org::CreateCashier.create(id: 1)
      #
      class CreateCashier < AuthorisedBase
        post :create, "/tellers/:id/cashiers", rubify_names: true
      end
    end
  end
end
