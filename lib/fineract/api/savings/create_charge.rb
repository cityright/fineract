# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::CreateCharge
      #   Fineract::Api::Savings::CreateCharge.create(id: 1)
      #
      class CreateCharge < AuthorisedBase
        post :create, "/savingsaccounts/:id/charges", rubify_names: true
      end
    end
  end
end
