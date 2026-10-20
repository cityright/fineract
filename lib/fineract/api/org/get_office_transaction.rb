# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetOfficeTransaction
      #   Fineract::Api::Org::GetOfficeTransaction.find(id: 1)
      #
      class GetOfficeTransaction < AuthorisedBase
        get :find, "/officetransactions/:id", rubify_names: true
      end
    end
  end
end
