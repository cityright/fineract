# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::DeleteIdentifier
      #   Fineract::Api::Client::DeleteIdentifier.remove(id: 1)
      #
      class DeleteIdentifier < AuthorisedBase
        delete :remove, "/clients/:id/identifiers/:identifierId", rubify_names: true
      end
    end
  end
end
