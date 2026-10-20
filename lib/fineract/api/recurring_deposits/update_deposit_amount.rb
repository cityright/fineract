# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::UpdateDepositAmount
      #   Fineract::Api::RecurringDeposits::UpdateDepositAmount.update_amount(id: 1)
      #
      class UpdateDepositAmount < AuthorisedBase
        post :update_amount, "/recurringdepositaccounts/:id?command=updateDepositAmount", rubify_names: true
      end
    end
  end
end
