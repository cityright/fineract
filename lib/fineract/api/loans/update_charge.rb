# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::UpdateCharge
      #   Fineract::Api::Loans::UpdateCharge.save(id: 1)
      #
      class UpdateCharge < AuthorisedBase
        put :save, "/loans/:id/charges/:chargeId", rubify_names: true
      end
    end
  end
end
