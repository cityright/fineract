# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::DeleteEntityDataTable
      #   Fineract::Api::System::DeleteEntityDataTable.remove(id: 1)
      #
      class DeleteEntityDataTable < AuthorisedBase
        delete :remove, "/entityDatatableChecks/:id", rubify_names: true
      end
    end
  end
end
