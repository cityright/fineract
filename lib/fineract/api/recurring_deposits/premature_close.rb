# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::PrematureClose
      #   Fineract::Api::RecurringDeposits::PrematureClose.premature_close(id: 1)
      #
      class PrematureClose < AuthorisedBase
        post :premature_close, "/recurringdepositaccounts/:id?command=prematureClose", rubify_names: true
      end
    end
  end
end
