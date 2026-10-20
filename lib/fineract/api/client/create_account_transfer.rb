# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::CreateAccountTransfer
      #   Fineract::Api::Client::CreateAccountTransfer.create()
      #
      class CreateAccountTransfer < AuthorisedBase
        post :create, "/accounttransfers", rubify_names: true
      end
    end
  end
end
