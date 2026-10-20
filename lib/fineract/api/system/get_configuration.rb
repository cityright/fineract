# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetConfiguration
      #   Fineract::Api::System::GetConfiguration.find()
      #
      class GetConfiguration < AuthorisedBase
        get :find, "/configurations", rubify_names: true
      end
    end
  end
end
