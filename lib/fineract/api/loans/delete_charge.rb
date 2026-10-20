# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::DeleteCharge
      #   Fineract::Api::Loans::DeleteCharge.remove(id: 1)
      #
      class DeleteCharge < AuthorisedBase
        delete :remove, "/loans/:id/charges/:chargeId", rubify_names: true
      end
    end
  end
end
