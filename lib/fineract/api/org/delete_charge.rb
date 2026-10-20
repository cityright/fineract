# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::DeleteCharge
      #   Fineract::Api::Org::DeleteCharge.remove(id: 1)
      #
      class DeleteCharge < AuthorisedBase
        delete :remove, "/charges/:id", rubify_names: true
      end
    end
  end
end
