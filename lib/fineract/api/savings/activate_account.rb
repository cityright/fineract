# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::ActivateAccount
      #   Fineract::Api::Savings::ActivateAccount.activate(id: 1)
      #
      class ActivateAccount < AuthorisedBase
        post :activate, "/savingsaccounts/:id?command=activate", rubify_names: true
      end
    end
  end
end
