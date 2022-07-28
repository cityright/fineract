# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UpdateClient
      #   Fineract::Api::Client::UpdateClient.save(params)
      #
      class UpdateClient < AuthorisedBase
        put :save, "/clients/:id", rubify_names: true
      end
    end
  end
end
