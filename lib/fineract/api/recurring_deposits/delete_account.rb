# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::DeleteAccount
      #   Fineract::Api::RecurringDeposits::DeleteAccount.remove(id: 1)
      #
      class DeleteAccount < AuthorisedBase
        delete :remove, "/recurringdepositaccounts/:id", rubify_names: true
      end
    end
  end
end
