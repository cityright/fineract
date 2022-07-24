# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::GetClient
      #   Fineract::Api::Client::GetClient.find(id)
      #
      #
      class GetClient < AuthorisedBase

        get :find, "/clients/:id", rubify_names: true
      end
    end
  end
end
