# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdateEntityDataTable
      #   Fineract::Api::System::UpdateEntityDataTable.save(id: 1)
      #
      class UpdateEntityDataTable < AuthorisedBase
        put :save, "/entityDatatableChecks/:id", rubify_names: true
      end
    end
  end
end
