# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UnblockAccount
      #   Fineract::Api::Savings::UnblockAccount.unblock(id: 1)
      #
      class UnblockAccount < AuthorisedBase
        post :unblock, "/savingsaccounts/:id?command=unblock", rubify_names: true
      end
    end
  end
end
