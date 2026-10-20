# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::RejectAccount
      #   Fineract::Api::RecurringDeposits::RejectAccount.reject(id: 1)
      #
      class RejectAccount < AuthorisedBase
        post :reject, "/recurringdepositaccounts/:id?command=reject", rubify_names: true
      end
    end
  end
end
