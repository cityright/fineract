# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client:: RetrieveClientAccounts
        #   Fineract::Api::Client::RetrieveClientAccounts.find(id)
        #
        #
        class RetrieveClientAccounts < AuthorisedBase
          before_request :camelize_params
  
          get :find, "/clients/:id/accounts", rubify_names: true
        end
      end
    end
  end
  