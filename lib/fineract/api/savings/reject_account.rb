# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::RejectAccount
      #   Fineract::Api::Savings::RejectAccount.reject(id: 1)
      #
      class RejectAccount < AuthorisedBase
        post :reject, "/savingsaccounts/:id?command=reject", rubify_names: true
      end
    end
  end
end
