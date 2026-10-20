# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::DeleteProvisioningCriteria
      #   Fineract::Api::Org::DeleteProvisioningCriteria.remove(id: 1)
      #
      class DeleteProvisioningCriteria < AuthorisedBase
        delete :remove, "/provisioningcriteria/:id", rubify_names: true
      end
    end
  end
end
