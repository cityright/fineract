# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::UpdateAccount
      #   Fineract::Api::RecurringDeposits::UpdateAccount.save(id: 1)
      #
      class UpdateAccount < AuthorisedBase
        put :save, "/recurringdepositaccounts/:id", rubify_names: true
      end
    end
  end
end
