# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::Login
      #   Fineract::Api::SelfService::Login.create()
      #
      class Login < AuthorisedBase
        post :create, "/self/authentication", rubify_names: true
      end
    end
  end
end
