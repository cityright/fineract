# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GetGuarantor
      #   Fineract::Api::Loans::GetGuarantor.find(id: 1)
      #
      class GetGuarantor < AuthorisedBase
        get :find, "/loans/:id/guarantors/:guarantorId", rubify_names: true
      end
    end
  end
end
