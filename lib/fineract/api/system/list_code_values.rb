# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ListCodeValues
      #   Fineract::Api::System::ListCodeValues.all(id: 1)
      #
      class ListCodeValues < AuthorisedBase
        get :all, "/codes/:id/codevalues", rubify_names: true
      end
    end
  end
end
