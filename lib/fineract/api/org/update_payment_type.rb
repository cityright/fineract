# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdatePaymentType
      #   Fineract::Api::Org::UpdatePaymentType.save(id: 1)
      #
      class UpdatePaymentType < AuthorisedBase
        put :save, "/paymenttypes/:id", rubify_names: true
      end
    end
  end
end
