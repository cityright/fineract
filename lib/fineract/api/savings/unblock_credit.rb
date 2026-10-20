# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UnblockCredit
      #   Fineract::Api::Savings::UnblockCredit.unblock_credit(id: 1)
      #
      class UnblockCredit < AuthorisedBase
        post :unblock_credit, "/savingsaccounts/:id?command=unblockCredit", rubify_names: true
      end
    end
  end
end
