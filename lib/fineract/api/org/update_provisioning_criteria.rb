# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateProvisioningCriteria
      #   Fineract::Api::Org::UpdateProvisioningCriteria.save(id: 1)
      #
      class UpdateProvisioningCriteria < AuthorisedBase
        put :save, "/provisioningcriteria/:id", rubify_names: true
      end
    end
  end
end
