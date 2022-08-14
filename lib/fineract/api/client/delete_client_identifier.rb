# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::DeleteClientIdentifier
      # params = { id: 10, identifier_id: 20}
      #   Fineract::Api::Client::DeleteClientIdentifier.remove(id)
      #
      class DeleteClientIdentifier < AuthorisedBase
        delete :remove, "/clients/:id/identifiers/:identifier_id", rubify_names: true
      end
    end
  end
end
