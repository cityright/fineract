# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::CreateEntityDataTable
      #   Fineract::Api::System::CreateEntityDataTable.create()
      #
      class CreateEntityDataTable < AuthorisedBase
        post :create, "/entityDatatableChecks", rubify_names: true
      end
    end
  end
end
