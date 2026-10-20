# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::ReleaseAmount
      #   Fineract::Api::Savings::ReleaseAmount.release(id: 1)
      #
      class ReleaseAmount < AuthorisedBase
        post :release, "/savingsaccounts/:id/transactions/:transactionId?command=releaseAmount", rubify_names: true
      end
    end
  end
end
