# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UndoRejectClient
      # Fineract::Api::Client::UndoRejectClient.create(id: 10, "reopenedDate":"28 November 2014","locale":"en","dateFormat":"dd MMMM yyyy")
      #
      class UndoRejectClient < AuthorisedBase
        post :create, "/clients/:id?command=UndoRejection", rubify_names: true
      end
    end
  end
end
