# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::ListSavings
      #   Fineract::Api::SelfService::ListSavings.all()
      #
      class ListSavings < AuthorisedBase
        get :all, "/self/savingsaccounts", rubify_names: true
      end
    end
  end
end
