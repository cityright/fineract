# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::GetRole
      #   Fineract::Api::Users::GetRole.find(id: 1)
      #
      class GetRole < AuthorisedBase
        get :find, "/roles/:id", rubify_names: true
      end
    end
  end
end
