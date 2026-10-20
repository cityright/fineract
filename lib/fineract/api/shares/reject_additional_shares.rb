# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::RejectAdditionalShares
      #   Fineract::Api::Shares::RejectAdditionalShares.reject(id: 1)
      #
      class RejectAdditionalShares < AuthorisedBase
        post :reject, "/accounts/share/:id?command=rejectadditionalshares", rubify_names: true
      end
    end
  end
end
