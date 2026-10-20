# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::GetUser
      #   Fineract::Api::Users::GetUser.find(id: 1)
      #
      class GetUser < AuthorisedBase
        get :find, "/users/:id", rubify_names: true
      end
    end
  end
end
