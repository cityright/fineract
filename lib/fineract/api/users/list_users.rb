# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::ListUsers
      #   Fineract::Api::Users::ListUsers.all()
      #
      class ListUsers < AuthorisedBase
        get :all, "/users", rubify_names: true
      end
    end
  end
end
