# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateProvisioningCriteria
      #   Fineract::Api::Org::CreateProvisioningCriteria.create()
      #
      class CreateProvisioningCriteria < AuthorisedBase
        post :create, "/provisioningcriteria", rubify_names: true
      end
    end
  end
end
