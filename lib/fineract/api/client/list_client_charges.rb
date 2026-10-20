# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::ListClientCharges
      #   Fineract::Api::Client::ListClientCharges.all(id: 1)
      #
      class ListClientCharges < AuthorisedBase
        get :all, "/clients/:id/charges", rubify_names: true
      end
    end
  end
end
