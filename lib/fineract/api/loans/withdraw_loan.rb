# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::WithdrawLoan
      #   Fineract::Api::Loans::WithdrawLoan.withdraw(id: 1)
      #
      class WithdrawLoan < AuthorisedBase
        post :withdraw, "/loans/:id?command=withdraw", rubify_names: true
      end
    end
  end
end
