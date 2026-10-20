# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::DisburseToSavings
      #   Fineract::Api::Loans::DisburseToSavings.disburse_to_savings(id: 1)
      #
      class DisburseToSavings < AuthorisedBase
        post :disburse_to_savings, "/loans/:id?command=disburseToSavings", rubify_names: true
      end
    end
  end
end
