# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UpdateCharge
      #   Fineract::Api::Savings::UpdateCharge.save(id: 1)
      #
      class UpdateCharge < AuthorisedBase
        put :save, "/savingsaccounts/:id/charges/:chargeId", rubify_names: true
      end
    end
  end
end
