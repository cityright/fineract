# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListPaymentTypes
      #   Fineract::Api::Org::ListPaymentTypes.all()
      #
      class ListPaymentTypes < AuthorisedBase
        get :all, "/paymenttypes", rubify_names: true
      end
    end
  end
end
