# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetDataTable
      #   Fineract::Api::System::GetDataTable.find(id: 1)
      #
      class GetDataTable < AuthorisedBase
        get :find, "/datatables/:id", rubify_names: true
      end
    end
  end
end
