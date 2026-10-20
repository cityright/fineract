# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::DeletePaymentType
      #   Fineract::Api::Org::DeletePaymentType.remove(id: 1)
      #
      class DeletePaymentType < AuthorisedBase
        delete :remove, "/paymenttypes/:id", rubify_names: true
      end
    end
  end
end
