# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetProvisioningCriteria
      #   Fineract::Api::Org::GetProvisioningCriteria.find(id: 1)
      #
      class GetProvisioningCriteria < AuthorisedBase
        get :find, "/provisioningcriteria/:id", rubify_names: true
      end
    end
  end
end
