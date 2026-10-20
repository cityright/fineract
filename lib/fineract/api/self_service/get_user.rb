# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::GetUser
      #   Fineract::Api::SelfService::GetUser.find()
      #
      class GetUser < AuthorisedBase
        get :find, "/self/user", rubify_names: true
      end
    end
  end
end
