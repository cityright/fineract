# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetAccountNumberFormat
      #   Fineract::Api::System::GetAccountNumberFormat.find(id: 1)
      #
      class GetAccountNumberFormat < AuthorisedBase
        get :find, "/accountnumberformats/:id", rubify_names: true
      end
    end
  end
end
