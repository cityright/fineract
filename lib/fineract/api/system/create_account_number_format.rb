# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::CreateAccountNumberFormat
      #   Fineract::Api::System::CreateAccountNumberFormat.create()
      #
      class CreateAccountNumberFormat < AuthorisedBase
        post :create, "/accountnumberformats", rubify_names: true
      end
    end
  end
end
