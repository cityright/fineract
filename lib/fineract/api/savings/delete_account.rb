# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::DeleteAccount
      #   Fineract::Api::Savings::DeleteAccount.remove(id: 1)
      #
      class DeleteAccount < AuthorisedBase
        delete :remove, "/savingsaccounts/:id", rubify_names: true
      end
    end
  end
end
