# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client:: RetrieveClientIdentifier
        # params = {id: 10, identifier_id: 20 }
        #   Fineract::Api::Client::RetrieveClientIdentifier.find(params)
        #
        #
        class RetrieveClientIdentifier < AuthorisedBase
          before_request :camelize_params
  
          get :find, "/clients/:id/identifiers/:identifier_id}", rubify_names: true
        end
      end
    end
  end
  