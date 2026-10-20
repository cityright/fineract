# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ListDataTables
      #   Fineract::Api::System::ListDataTables.all()
      #
      class ListDataTables < AuthorisedBase
        get :all, "/datatables", rubify_names: true
      end
    end
  end
end
