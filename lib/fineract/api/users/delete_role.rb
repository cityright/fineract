# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::DeleteRole
      #   Fineract::Api::Users::DeleteRole.remove(id: 1)
      #
      class DeleteRole < AuthorisedBase
        delete :remove, "/roles/:id", rubify_names: true
      end
    end
  end
end
