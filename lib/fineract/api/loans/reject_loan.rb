# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::RejectLoan
      #   Fineract::Api::Loans::RejectLoan.reject(id: 1)
      #
      class RejectLoan < AuthorisedBase
        post :reject, "/loans/:id?command=reject", rubify_names: true
      end
    end
  end
end
