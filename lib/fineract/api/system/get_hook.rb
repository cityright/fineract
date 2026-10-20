# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetHook
      #   Fineract::Api::System::GetHook.find(id: 1)
      #
      class GetHook < AuthorisedBase
        get :find, "/hooks/:id", rubify_names: true
      end
    end
  end
end
