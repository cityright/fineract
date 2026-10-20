# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Client
      # @example Client::ProposeTransfer
      #   Fineract::Api::Client::ProposeTransfer.create(id:10, "transferDate":"28 August 2018","destinationOfficeId":"2","note":"Client Relocating to Bangalore")
      #
      #
      class ProposeTransfer < AuthorisedBase
        post :propose, "/clients/:id?command=proposeTransfer", rubify_names: true
      end
    end
  end
end
# rubocop:enable Layout/LineLength
