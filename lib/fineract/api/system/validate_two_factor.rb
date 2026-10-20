# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ValidateTwoFactor
      #   Fineract::Api::System::ValidateTwoFactor.validate()
      #
      class ValidateTwoFactor < AuthorisedBase
        post :validate, "/twofactor/validate", rubify_names: true
      end
    end
  end
end
