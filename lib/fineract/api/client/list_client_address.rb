# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::ListClientAddress
      #   Fineract::Api::Client::ListClientAddress.all(id: 10)
      #
      class ListClientAddress < AuthorisedBase
        get :all, "/client/:id/addresses", rubify_names: true
      end
    end
  end
end
