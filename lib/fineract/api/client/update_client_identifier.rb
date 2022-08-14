# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client::UpdateClientIdentifier
        # params = { id: 10, identifier_id: 12,  "documentTypeId":"1","documentKey":"KA-54677","description":"Document has been verified"}
        #   Fineract::Api::Client::UpdateClientIdentifier.save(params)
        #
        class UpdateClientIdentifier < AuthorisedBase
          put :save, "/clients/:id/identifiers/:identifier_id", rubify_names: true
        end
      end
    end
  end
  