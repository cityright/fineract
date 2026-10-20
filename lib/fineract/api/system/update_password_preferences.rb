# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdatePasswordPreferences
      #   Fineract::Api::System::UpdatePasswordPreferences.save()
      #
      class UpdatePasswordPreferences < AuthorisedBase
        put :save, "/passwordpreferences", rubify_names: true
      end
    end
  end
end
