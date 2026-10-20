# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::GetAccount
      #   Fineract::Api::RecurringDeposits::GetAccount.find(id: 1)
      #
      class GetAccount < AuthorisedBase
        get :find, "/recurringdepositaccounts/:id", rubify_names: true
      end
    end
  end
end
