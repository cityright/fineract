# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::RedeemShares
      #   Fineract::Api::Shares::RedeemShares.redeem(id: 1)
      #
      class RedeemShares < AuthorisedBase
        post :redeem, "/accounts/share/:id?command=redeemshares", rubify_names: true
      end
    end
  end
end
