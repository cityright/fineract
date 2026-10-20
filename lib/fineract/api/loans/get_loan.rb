# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GetLoan
      #   Fineract::Api::Loans::GetLoan.find(id: 1)
      #
      class GetLoan < AuthorisedBase
        get :find, "/loans/:id", rubify_names: true
      end
    end
  end
end
