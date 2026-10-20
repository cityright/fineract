# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::ListProvisioningEntries
      #   Fineract::Api::Accounting::ListProvisioningEntries.all()
      #
      class ListProvisioningEntries < AuthorisedBase
        get :all, "/provisioningentries", rubify_names: true
      end
    end
  end
end
