# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListProvisioningCriteria
      #   Fineract::Api::Org::ListProvisioningCriteria.all()
      #
      class ListProvisioningCriteria < AuthorisedBase
        get :all, "/provisioningcriteria", rubify_names: true
      end
    end
  end
end
