# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Client
      # @example Client::ProposeAndAcceptTransfer
      #   Fineract::Api::Client::ProposeAndAcceptTransfer.create(id:10,"destinationOfficeId":"2","destinationGroupId":"13","staffId":"1","note":"Client Relocating to Bangalore")
      #
      #
      class ProposeAndAcceptTransfer < AuthorisedBase
        post :create, "/clients/:id?command=proposeAndAcceptTransfer", rubify_names: true
      end
    end
  end
end
# rubocop:enable Layout/LineLength
