# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::CreateDataTable
      #   Fineract::Api::System::CreateDataTable.create()
      #
      class CreateDataTable < AuthorisedBase
        post :create, "/datatables", rubify_names: true
      end
    end
  end
end
