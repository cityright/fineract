# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::ListClientTransactions
      #   Fineract::Api::Client::ListClientTransactions.all(id: 1)
      #
      class ListClientTransactions < AuthorisedBase
        get :all, "/clients/:id/transactions", rubify_names: true
      end
    end
  end
end
