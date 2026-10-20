# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetCashierTemplate
      #   Fineract::Api::Org::GetCashierTemplate.template(id: 1)
      #
      class GetCashierTemplate < AuthorisedBase
        get :template, "/tellers/:id/cashiers/template", rubify_names: true
      end
    end
  end
end
