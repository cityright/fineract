# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GetAccount
      #   Fineract::Api::Savings::GetAccount.find(id: 1)
      #
      class GetAccount < AuthorisedBase
        get :find, "/savingsaccounts/:id", rubify_names: true
      end
    end
  end
end
