# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::ApproveAccount
      #   Fineract::Api::Shares::ApproveAccount.approve(id: 1)
      #
      class ApproveAccount < AuthorisedBase
        post :approve, "/accounts/share/:id?command=approve", rubify_names: true
      end
    end
  end
end
