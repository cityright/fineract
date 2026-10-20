# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GetCharge
      #   Fineract::Api::Loans::GetCharge.find(id: 1)
      #
      class GetCharge < AuthorisedBase
        get :find, "/loans/:id/charges/:chargeId", rubify_names: true
      end
    end
  end
end
