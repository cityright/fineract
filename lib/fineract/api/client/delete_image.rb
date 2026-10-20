# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::DeleteImage
      #   Fineract::Api::Client::DeleteImage.remove(id: 1)
      #
      class DeleteImage < AuthorisedBase
        delete :remove, "/clients/:id/images", rubify_names: true
      end
    end
  end
end
