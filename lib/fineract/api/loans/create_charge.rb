# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::CreateCharge
      #   Fineract::Api::Loans::CreateCharge.create(id: 1)
      #
      class CreateCharge < AuthorisedBase
        post :create, "/loans/:id/charges", rubify_names: true
      end
    end
  end
end
