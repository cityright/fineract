# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::CreateUser
      #   Fineract::Api::Users::CreateUser.create()
      #
      class CreateUser < AuthorisedBase
        post :create, "/users", rubify_names: true
      end
    end
  end
end
