# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::RecoverGuarantees
      #   Fineract::Api::Loans::RecoverGuarantees.recover(id: 1)
      #
      class RecoverGuarantees < AuthorisedBase
        post :recover, "/loans/:id?command=recoverGuarantees", rubify_names: true
      end
    end
  end
end
