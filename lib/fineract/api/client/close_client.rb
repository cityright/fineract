# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::CloseClient
      #   Fineract::Api::Client::CloseClient.create(id:10, "dateFormat":"dd MMMM yyyy","locale":"en","closureDate":"25 June 2013")
      #
      #
      class CloseClient < AuthorisedBase
        post :close, "/clients/:id?command=close", rubify_names: true
      end
    end
  end
end
# rubocop:enable Layout/LineLength
