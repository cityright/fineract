# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::DisburseLoan
      #   Fineract::Api::Loans::DisburseLoan.disburse(id: 1)
      #
      class DisburseLoan < AuthorisedBase
        post :disburse, "/loans/:id?command=disburse", rubify_names: true
      end
    end
  end
end
