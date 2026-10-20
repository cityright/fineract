# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UpdateWithholdTax
      #   Fineract::Api::Savings::UpdateWithholdTax.save(id: 1)
      #
      class UpdateWithholdTax < AuthorisedBase
        put :save, "/savingsaccounts/:id?command=updateWithHoldTax", rubify_names: true
      end
    end
  end
end
