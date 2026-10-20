# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::UpdateCollateral
      #   Fineract::Api::Loans::UpdateCollateral.save(id: 1)
      #
      class UpdateCollateral < AuthorisedBase
        put :save, "/loans/:id/collaterals/:collateralId", rubify_names: true
      end
    end
  end
end
