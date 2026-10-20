# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::CloseAccount
      #   Fineract::Api::RecurringDeposits::CloseAccount.close(id: 1)
      #
      class CloseAccount < AuthorisedBase
        post :close, "/recurringdepositaccounts/:id?command=close", rubify_names: true
      end
    end
  end
end
