# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::DeleteUser
      #   Fineract::Api::Users::DeleteUser.remove(id: 1)
      #
      class DeleteUser < AuthorisedBase
        delete :remove, "/users/:id", rubify_names: true
      end
    end
  end
end
