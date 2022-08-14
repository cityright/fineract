# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
    module Api
      module Client
        # @example Client::CreateClientIdentifier
        # params = { id: 10, "documentTypeId":"1","documentKey":"KA-54677","description":"Document has been verified"}
        #  Fineract::Api::Client::CreateClientIdentifier.create(params)
        #
  
        class CreateClientIdentifier < AuthorisedBase
          post :create, "/clients/:id/identifiers", rubify_names: true
  
          validates :documentTypeId, presence: true
          validates :documentKey, presence: true
          validates :id, presence: true
        end
      end
    end
  end
  # rubocop:enable Layout/LineLength
  