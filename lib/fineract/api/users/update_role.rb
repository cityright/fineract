# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::UpdateRole
      #   Fineract::Api::Users::UpdateRole.save(id: 1)
      #
      class UpdateRole < AuthorisedBase
        put :save, "/roles/:id", rubify_names: true
      end
    end
  end
end
