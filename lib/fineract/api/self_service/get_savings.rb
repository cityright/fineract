# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::GetSavings
      #   Fineract::Api::SelfService::GetSavings.find(id: 1)
      #
      class GetSavings < AuthorisedBase
        get :find, "/self/savingsaccounts/:id", rubify_names: true
      end
    end
  end
end
