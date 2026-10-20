# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::ApproveAccount
      #   Fineract::Api::Savings::ApproveAccount.approve(id: 1)
      #
      class ApproveAccount < AuthorisedBase
        post :approve, "/savingsaccounts/:id?command=approve", rubify_names: true
      end
    end
  end
end
