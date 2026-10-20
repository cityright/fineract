# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::ActivateAccount
      #   Fineract::Api::RecurringDeposits::ActivateAccount.activate(id: 1)
      #
      class ActivateAccount < AuthorisedBase
        post :activate, "/recurringdepositaccounts/:id?command=activate", rubify_names: true
      end
    end
  end
end
