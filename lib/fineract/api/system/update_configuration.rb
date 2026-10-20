# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdateConfiguration
      #   Fineract::Api::System::UpdateConfiguration.save()
      #
      class UpdateConfiguration < AuthorisedBase
        put :save, "/configurations", rubify_names: true
      end
    end
  end
end
