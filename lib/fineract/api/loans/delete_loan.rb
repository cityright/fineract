# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::DeleteLoan
      #   Fineract::Api::Loans::DeleteLoan.remove(id: 1)
      #
      class DeleteLoan < AuthorisedBase
        delete :remove, "/loans/:id", rubify_names: true
      end
    end
  end
end
