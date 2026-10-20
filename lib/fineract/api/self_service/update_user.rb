# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::UpdateUser
      #   Fineract::Api::SelfService::UpdateUser.save()
      #
      class UpdateUser < AuthorisedBase
        put :save, "/self/user", rubify_names: true
      end
    end
  end
end
