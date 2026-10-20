# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetEntityDataTable
      #   Fineract::Api::System::GetEntityDataTable.find()
      #
      class GetEntityDataTable < AuthorisedBase
        get :find, "/entityDatatableChecks", rubify_names: true
      end
    end
  end
end
