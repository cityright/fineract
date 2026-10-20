# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UploadImage
      #   Fineract::Api::Client::UploadImage.create(id: 1)
      #
      class UploadImage < AuthorisedBase
        post :create, "/clients/:id/images", rubify_names: true
      end
    end
  end
end
