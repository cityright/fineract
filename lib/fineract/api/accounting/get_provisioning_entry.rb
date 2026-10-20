# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::GetProvisioningEntry
      #   Fineract::Api::Accounting::GetProvisioningEntry.find(id: 1)
      #
      class GetProvisioningEntry < AuthorisedBase
        get :find, "/provisioningentries/:id", rubify_names: true
      end
    end
  end
end
