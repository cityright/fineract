# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::ListCharges
      #   Fineract::Api::Loans::ListCharges.all(id: 1)
      #
      class ListCharges < AuthorisedBase
        get :all, "/loans/:id/charges", rubify_names: true
      end
    end
  end
end
