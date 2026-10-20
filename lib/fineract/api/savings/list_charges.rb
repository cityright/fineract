# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::ListCharges
      #   Fineract::Api::Savings::ListCharges.all(id: 1)
      #
      class ListCharges < AuthorisedBase
        get :all, "/savingsaccounts/:id/charges", rubify_names: true
      end
    end
  end
end
