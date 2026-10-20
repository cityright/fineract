# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::ListAccountTransfers
      #   Fineract::Api::Client::ListAccountTransfers.all()
      #
      class ListAccountTransfers < AuthorisedBase
        get :all, "/accounttransfers", rubify_names: true
      end
    end
  end
end
