# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::CreateHook
      #   Fineract::Api::System::CreateHook.create()
      #
      class CreateHook < AuthorisedBase
        post :create, "/hooks", rubify_names: true
      end
    end
  end
end
