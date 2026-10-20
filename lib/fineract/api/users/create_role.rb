# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::CreateRole
      #   Fineract::Api::Users::CreateRole.create()
      #
      class CreateRole < AuthorisedBase
        post :create, "/roles", rubify_names: true
      end
    end
  end
end
