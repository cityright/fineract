# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::RefundByCash
      #   Fineract::Api::Loans::RefundByCash.refund(id: 1)
      #
      class RefundByCash < AuthorisedBase
        post :refund, "/loans/:id/transactions?command=refundByCash", rubify_names: true
      end
    end
  end
end
