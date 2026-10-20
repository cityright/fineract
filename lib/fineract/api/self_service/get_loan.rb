# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::GetLoan
      #   Fineract::Api::SelfService::GetLoan.find(id: 1)
      #
      class GetLoan < AuthorisedBase
        get :find, "/self/loans/:id", rubify_names: true
      end
    end
  end
end
