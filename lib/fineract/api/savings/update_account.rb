# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UpdateAccount
      #   Fineract::Api::Savings::UpdateAccount.save(id: 1)
      #
      class UpdateAccount < AuthorisedBase
        put :save, "/savingsaccounts/:id", rubify_names: true
      end
    end
  end
end
