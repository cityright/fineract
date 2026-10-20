# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreatePaymentType
      #   Fineract::Api::Org::CreatePaymentType.create()
      #
      class CreatePaymentType < AuthorisedBase
        post :create, "/paymenttypes", rubify_names: true
      end
    end
  end
end
