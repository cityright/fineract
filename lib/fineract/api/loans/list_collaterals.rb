# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::ListCollaterals
      #   Fineract::Api::Loans::ListCollaterals.all(id: 1)
      #
      class ListCollaterals < AuthorisedBase
        get :all, "/loans/:id/collaterals", rubify_names: true
      end
    end
  end
end
