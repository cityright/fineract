# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::ListIdentifiers
      #   Fineract::Api::Client::ListIdentifiers.all(id: 1)
      #
      class ListIdentifiers < AuthorisedBase
        get :all, "/clients/:id/identifiers", rubify_names: true
      end
    end
  end
end
