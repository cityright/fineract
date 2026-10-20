# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::GetImage
      #   Fineract::Api::Client::GetImage.find(id: 1)
      #
      class GetImage < AuthorisedBase
        get :find, "/clients/:id/images", rubify_names: true
      end
    end
  end
end
