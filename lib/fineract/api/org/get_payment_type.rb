# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetPaymentType
      #   Fineract::Api::Org::GetPaymentType.find(id: 1)
      #
      class GetPaymentType < AuthorisedBase
        get :find, "/paymenttypes/:id", rubify_names: true
      end
    end
  end
end
