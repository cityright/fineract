# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::ListRoles
      #   Fineract::Api::Users::ListRoles.all()
      #
      class ListRoles < AuthorisedBase
        get :all, "/roles", rubify_names: true
      end
    end
  end
end
