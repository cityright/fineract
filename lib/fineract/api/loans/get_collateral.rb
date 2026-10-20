# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GetCollateral
      #   Fineract::Api::Loans::GetCollateral.find(id: 1)
      #
      class GetCollateral < AuthorisedBase
        get :find, "/loans/:id/collaterals/:collateralId", rubify_names: true
      end
    end
  end
end
