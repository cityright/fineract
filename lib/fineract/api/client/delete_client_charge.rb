# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::DeleteClientCharge
      #   Fineract::Api::Client::DeleteClientCharge.remove(id: 1)
      #
      class DeleteClientCharge < AuthorisedBase
        delete :remove, "/clients/:id/charges/:chargeId", rubify_names: true
      end
    end
  end
end
