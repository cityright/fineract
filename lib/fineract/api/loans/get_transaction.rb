# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GetTransaction
      #   Fineract::Api::Loans::GetTransaction.find(id: 1)
      #
      class GetTransaction < AuthorisedBase
        get :find, "/loans/:id/transactions/:transactionId", rubify_names: true
      end
    end
  end
end
