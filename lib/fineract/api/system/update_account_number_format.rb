# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdateAccountNumberFormat
      #   Fineract::Api::System::UpdateAccountNumberFormat.save(id: 1)
      #
      class UpdateAccountNumberFormat < AuthorisedBase
        put :save, "/accountnumberformats/:id", rubify_names: true
      end
    end
  end
end
