# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetTwoFactor
      #   Fineract::Api::System::GetTwoFactor.find()
      #
      class GetTwoFactor < AuthorisedBase
        get :find, "/twofactor", rubify_names: true
      end
    end
  end
end
