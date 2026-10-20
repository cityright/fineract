# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdateHook
      #   Fineract::Api::System::UpdateHook.save(id: 1)
      #
      class UpdateHook < AuthorisedBase
        put :save, "/hooks/:id", rubify_names: true
      end
    end
  end
end
