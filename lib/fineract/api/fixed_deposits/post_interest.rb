# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::PostInterest
      #   Fineract::Api::FixedDeposits::PostInterest.post(id: 1)
      #
      class PostInterest < AuthorisedBase
        post :post, "/fixeddepositaccounts/:id?command=postInterest", rubify_names: true
      end
    end
  end
end
