# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::InvalidateTwoFactor
      #   Fineract::Api::System::InvalidateTwoFactor.invalidate()
      #
      class InvalidateTwoFactor < AuthorisedBase
        post :invalidate, "/twofactor/invalidate", rubify_names: true
      end
    end
  end
end
