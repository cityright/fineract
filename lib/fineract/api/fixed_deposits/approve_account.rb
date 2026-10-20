# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::ApproveAccount
      #   Fineract::Api::FixedDeposits::ApproveAccount.approve(id: 1)
      #
      class ApproveAccount < AuthorisedBase
        post :approve, "/fixeddepositaccounts/:id?command=approve", rubify_names: true
      end
    end
  end
end
