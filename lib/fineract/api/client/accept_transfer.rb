module Fineract
  module Api
    module Client
      # @example Client::AcceptTransfer
      #   Fineract::Api::Client::AcceptTransfer.create(id:10, "destinationGroupId":"13","staffId":"1","note":"Due Diligence done and all documents received")
      #
      #
      class AcceptTransfer < AuthorisedBase
        post :create, "/clients/:id?command=acceptTransfer", rubify_names: true
      end
    end
  end
end
