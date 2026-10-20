# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::TransactionTemplate
      #   Fineract::Api::Savings::TransactionTemplate.template(id: 1)
      #
      class TransactionTemplate < AuthorisedBase
        get :template, "/savingsaccounts/:id/transactions/template", rubify_names: true
      end
    end
  end
end
