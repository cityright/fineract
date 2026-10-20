# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::PrepayLoan
      #   Fineract::Api::Loans::PrepayLoan.prepay(id: 1)
      #
      class PrepayLoan < AuthorisedBase
        post :prepay, "/loans/:id/transactions?command=prepayLoan", rubify_names: true
      end
    end
  end
end
