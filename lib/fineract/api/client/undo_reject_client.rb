# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Client
      # @example Client::UndoRejectClient
      # Fineract::Api::Client::UndoRejectClient.create(id: 10, "reopenedDate":"28 November 2014","locale":"en","dateFormat":"dd MMMM yyyy")
      #
      class UndoRejectClient < AuthorisedBase
        post :undo_reject, "/clients/:id?command=UndoRejection", rubify_names: true
      end
    end
  end
end
# rubocop:enable Layout/LineLength
