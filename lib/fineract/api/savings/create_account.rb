# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::CreateAccount
      #   Fineract::Api::Savings::CreateAccount.create()
      #
      class CreateAccount < AuthorisedBase
        post :create, "/savingsaccounts", rubify_names: true
      end
    end
  end
end
