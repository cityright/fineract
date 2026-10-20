# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdateDataTable
      #   Fineract::Api::System::UpdateDataTable.save(id: 1)
      #
      class UpdateDataTable < AuthorisedBase
        put :save, "/datatables/:id", rubify_names: true
      end
    end
  end
end
