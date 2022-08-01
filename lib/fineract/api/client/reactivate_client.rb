# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Client
      # @example Client::ReactivateClient
      # Fineract::Api::Client::ReactivateClient.create(id: 10, "reactivationDate":"28 November 2014","locale":"en","dateFormat":"dd MMMM yyyy")
      #
      class ReactivateClient < AuthorisedBase
        post :create, "/clients/:id?command=reactivate", rubify_names: true
      end
    end
  end
end
# rubocop:enable Layout/LineLength
