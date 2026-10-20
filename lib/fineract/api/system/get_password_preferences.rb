# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetPasswordPreferences
      #   Fineract::Api::System::GetPasswordPreferences.find()
      #
      class GetPasswordPreferences < AuthorisedBase
        get :find, "/passwordpreferences", rubify_names: true
      end
    end
  end
end
