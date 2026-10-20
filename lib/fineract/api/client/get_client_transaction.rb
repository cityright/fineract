# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::GetClientTransaction
      #   Fineract::Api::Client::GetClientTransaction.find(id: 1)
      #
      class GetClientTransaction < AuthorisedBase
        get :find, "/clients/:id/transactions/:transactionId", rubify_names: true
      end
    end
  end
end
