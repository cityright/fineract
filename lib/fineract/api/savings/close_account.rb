# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::CloseAccount
      #   Fineract::Api::Savings::CloseAccount.close(id: 1)
      #
      class CloseAccount < AuthorisedBase
        post :close, "/savingsaccounts/:id?command=close", rubify_names: true
      end
    end
  end
end
