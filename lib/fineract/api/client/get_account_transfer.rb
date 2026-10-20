# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::GetAccountTransfer
      #   Fineract::Api::Client::GetAccountTransfer.find(id: 1)
      #
      class GetAccountTransfer < AuthorisedBase
        get :find, "/accounttransfers/:id", rubify_names: true
      end
    end
  end
end
