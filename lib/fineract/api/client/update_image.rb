# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UpdateImage
      #   Fineract::Api::Client::UpdateImage.save(id: 1)
      #
      class UpdateImage < AuthorisedBase
        put :save, "/clients/:id/images", rubify_names: true
      end
    end
  end
end
