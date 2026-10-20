# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::CreateAccount
      #   Fineract::Api::RecurringDeposits::CreateAccount.create()
      #
      class CreateAccount < AuthorisedBase
        post :create, "/recurringdepositaccounts", rubify_names: true
      end
    end
  end
end
