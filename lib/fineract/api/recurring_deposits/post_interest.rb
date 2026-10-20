# frozen_string_literal: true

module Fineract
  module Api
    module RecurringDeposits
      # @example RecurringDeposits::PostInterest
      #   Fineract::Api::RecurringDeposits::PostInterest.post(id: 1)
      #
      class PostInterest < AuthorisedBase
        post :post, "/recurringdepositaccounts/:id?command=postInterest", rubify_names: true
      end
    end
  end
end
