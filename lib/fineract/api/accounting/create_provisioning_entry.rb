# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::CreateProvisioningEntry
      #   Fineract::Api::Accounting::CreateProvisioningEntry.create()
      #
      class CreateProvisioningEntry < AuthorisedBase
        post :create, "/provisioningentries", rubify_names: true
      end
    end
  end
end
