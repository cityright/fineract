# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::CreateCollateral
      #   Fineract::Api::Loans::CreateCollateral.create(id: 1)
      #
      class CreateCollateral < AuthorisedBase
        post :create, "/loans/:id/collaterals", rubify_names: true
      end
    end
  end
end
