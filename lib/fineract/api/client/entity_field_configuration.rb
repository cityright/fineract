# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::GetClient
      # params = {entity: 'ADDRESS'}
      #   Fineract::Api::Client::EntityFieldConfiguration.find(params)
      #
      #
      class EntityFieldConfiguration < AuthorisedBase
        get :find, "/fieldconfiguration/:entity", rubify_names: true
      end
    end
  end
end
