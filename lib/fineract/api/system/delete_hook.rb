# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::DeleteHook
      #   Fineract::Api::System::DeleteHook.remove(id: 1)
      #
      class DeleteHook < AuthorisedBase
        delete :remove, "/hooks/:id", rubify_names: true
      end
    end
  end
end
