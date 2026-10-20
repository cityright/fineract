# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::DeleteCollateral
      #   Fineract::Api::Loans::DeleteCollateral.remove(id: 1)
      #
      class DeleteCollateral < AuthorisedBase
        delete :remove, "/loans/:id/collaterals/:collateralId", rubify_names: true
      end
    end
  end
end
