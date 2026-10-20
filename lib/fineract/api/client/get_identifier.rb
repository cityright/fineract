# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::GetIdentifier
      #   Fineract::Api::Client::GetIdentifier.find(id: 1)
      #
      class GetIdentifier < AuthorisedBase
        get :find, "/clients/:id/identifiers/:identifierId", rubify_names: true
      end
    end
  end
end
