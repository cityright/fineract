# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client::ListClientIdentifiers
        # params = {id: 10}
        #   Fineract::Api::Client::ListClientIdentifiers.all(params)
        #
        class Client::ListClientIdentifiers < AuthorisedBase
          get :all, "/clients/:id/identifiers", rubify_names: true
        end
      end
    end
  end
  