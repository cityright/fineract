# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::DeleteAccountNumberFormat
      #   Fineract::Api::System::DeleteAccountNumberFormat.remove(id: 1)
      #
      class DeleteAccountNumberFormat < AuthorisedBase
        delete :remove, "/accountnumberformats/:id", rubify_names: true
      end
    end
  end
end
