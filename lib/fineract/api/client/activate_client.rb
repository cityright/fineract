# frozen_string_literal: true

# rubocop:disable Layout/LineLength

module Fineract
  module Api
    module Client
      # @example Client::ActivateClient
      #   Fineract::Api::Client::ActivateClient.create(id: 10, "locale": "en", "dateFormat": "dd MMMM yyyy", "activationDate": "24 July 2022")
      #
      #
      class ActivateClient < AuthorisedBase
        post :create, "/clients/:id?command=activate", rubify_names: true
      end
    end
  end
end

# rubocop:enable Layout/LineLength
