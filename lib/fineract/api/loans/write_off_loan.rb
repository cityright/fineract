# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::WriteOffLoan
      #   Fineract::Api::Loans::WriteOffLoan.write_off(id: 1)
      #
      class WriteOffLoan < AuthorisedBase
        post :write_off, "/loans/:id/transactions?command=writeoff", rubify_names: true
      end
    end
  end
end
