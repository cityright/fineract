# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::ApproveAdditionalShares
      #   Fineract::Api::Shares::ApproveAdditionalShares.approve(id: 1)
      #
      class ApproveAdditionalShares < AuthorisedBase
        post :approve, "/accounts/share/:id?command=approveadditionalshares", rubify_names: true
      end
    end
  end
end
