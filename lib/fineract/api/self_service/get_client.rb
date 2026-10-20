# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::GetClient
      #   Fineract::Api::SelfService::GetClient.find(id: 1)
      #
      class GetClient < AuthorisedBase
        get :find, "/self/clients/:id", rubify_names: true
      end
    end
  end
end
