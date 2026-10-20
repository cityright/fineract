# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::ApplyAdditionalShares
      #   Fineract::Api::Shares::ApplyAdditionalShares.apply(id: 1)
      #
      class ApplyAdditionalShares < AuthorisedBase
        post :apply, "/accounts/share/:id?command=applyadditionalshares", rubify_names: true
      end
    end
  end
end
