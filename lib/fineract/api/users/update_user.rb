# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::UpdateUser
      #   Fineract::Api::Users::UpdateUser.save(id: 1)
      #
      class UpdateUser < AuthorisedBase
        put :save, "/users/:id", rubify_names: true
      end
    end
  end
end
