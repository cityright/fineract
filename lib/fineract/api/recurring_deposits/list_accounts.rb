# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::ListAccounts
      #   Fineract::Api::RecurringDeposits::ListAccounts.all()
      #
      class ListAccounts < AuthorisedBase
        get :all, "/recurringdepositaccounts", rubify_names: true
      end
    end
  end
end
