# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::CreateClientCharge
      #   Fineract::Api::Client::CreateClientCharge.create(id: 1)
      #
      class CreateClientCharge < AuthorisedBase
        post :create, "/clients/:id/charges", rubify_names: true
      end
    end
  end
end
