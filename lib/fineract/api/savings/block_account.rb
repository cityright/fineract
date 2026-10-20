# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::BlockAccount
      #   Fineract::Api::Savings::BlockAccount.block(id: 1)
      #
      class BlockAccount < AuthorisedBase
        post :block, "/savingsaccounts/:id?command=block", rubify_names: true
      end
    end
  end
end
