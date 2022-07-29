# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::ListClients
      #   Fineract::Api::Client::ListClients.all()
      #
      class ListClients < AuthorisedBase
        get :all, "/clients", rubify_names: true
      end
    end
  end
end
