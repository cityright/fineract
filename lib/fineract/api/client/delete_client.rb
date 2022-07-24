# frozen_string_literal: true
module Fineract
  module Api
    module Client
      # @example Client::DeleteClient
      #   Fineract::Api::Client::DeleteClient.remove(id)
      #
      class DeleteClient < AuthorisedBase
  
        delete :remove, "/clients/:id", rubify_names: true
      end
    end
  end
end
