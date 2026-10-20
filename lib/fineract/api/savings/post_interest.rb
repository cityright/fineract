# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::PostInterest
      #   Fineract::Api::Savings::PostInterest.post(id: 1)
      #
      class PostInterest < AuthorisedBase
        post :post, "/savingsaccounts/:id?command=postInterest", rubify_names: true
      end
    end
  end
end
