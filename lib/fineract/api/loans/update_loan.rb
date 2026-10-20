# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::UpdateLoan
      #   Fineract::Api::Loans::UpdateLoan.save(id: 1)
      #
      class UpdateLoan < AuthorisedBase
        put :save, "/loans/:id", rubify_names: true
      end
    end
  end
end
