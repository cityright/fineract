# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::CreateIdentifier
      #   Fineract::Api::Client::CreateIdentifier.create(id: 1)
      #
      class CreateIdentifier < AuthorisedBase
        post :create, "/clients/:id/identifiers", rubify_names: true
      end
    end
  end
end
