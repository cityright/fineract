# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::RepayLoan
      #   Fineract::Api::Loans::RepayLoan.repay(id: 1)
      #
      class RepayLoan < AuthorisedBase
        post :repay, "/loans/:id/transactions?command=repayment", rubify_names: true
      end
    end
  end
end
