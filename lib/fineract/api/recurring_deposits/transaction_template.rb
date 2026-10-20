# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::TransactionTemplate
      #   Fineract::Api::RecurringDeposits::TransactionTemplate.template(id: 1)
      #
      class TransactionTemplate < AuthorisedBase
        get :template, "/recurringdepositaccounts/:id/transactions/template", rubify_names: true
      end
    end
  end
end
