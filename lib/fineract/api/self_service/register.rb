# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::Register
      #   Fineract::Api::SelfService::Register.create()
      #
      class Register < AuthorisedBase
        post :create, "/self/registration", rubify_names: true
      end
    end
  end
end
