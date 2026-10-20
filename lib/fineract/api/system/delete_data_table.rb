# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::DeleteDataTable
      #   Fineract::Api::System::DeleteDataTable.remove(id: 1)
      #
      class DeleteDataTable < AuthorisedBase
        delete :remove, "/datatables/:id", rubify_names: true
      end
    end
  end
end
