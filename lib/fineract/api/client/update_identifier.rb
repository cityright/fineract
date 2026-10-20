# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UpdateIdentifier
      #   Fineract::Api::Client::UpdateIdentifier.save(id: 1)
      #
      class UpdateIdentifier < AuthorisedBase
        put :save, "/clients/:id/identifiers/:identifierId", rubify_names: true
      end
    end
  end
end
