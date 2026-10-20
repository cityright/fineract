# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::RecoveryPayment
      #   Fineract::Api::Loans::RecoveryPayment.recovery(id: 1)
      #
      class RecoveryPayment < AuthorisedBase
        post :recovery, "/loans/:id/transactions?command=recoverypayment", rubify_names: true
      end
    end
  end
end
