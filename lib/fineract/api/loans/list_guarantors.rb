# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::ListGuarantors
      #   Fineract::Api::Loans::ListGuarantors.all(id: 1)
      #
      class ListGuarantors < AuthorisedBase
        get :all, "/loans/:id/guarantors", rubify_names: true
      end
    end
  end
end
