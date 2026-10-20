# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::ApproveAccount
      #   Fineract::Api::RecurringDeposits::ApproveAccount.approve(id: 1)
      #
      class ApproveAccount < AuthorisedBase
        post :approve, "/recurringdepositaccounts/:id?command=approve", rubify_names: true
      end
    end
  end
end
