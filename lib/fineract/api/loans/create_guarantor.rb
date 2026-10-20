# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::CreateGuarantor
      #   Fineract::Api::Loans::CreateGuarantor.create(id: 1)
      #
      class CreateGuarantor < AuthorisedBase
        post :create, "/loans/:id/guarantors", rubify_names: true
      end
    end
  end
end
