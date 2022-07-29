# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Client
      # @example Client::UndoWithdrawClient
      # Fineract::Api::Client::UndoWithdrawClient.create(id: 10, "reopenedDate":"28 November 2014","locale":"en","dateFormat":"dd MMMM yyyy")
      #
      class UndoWithdrawClient < AuthorisedBase
        post :create, "/clients/:id?command=UndoWithdrawal", rubify_names: true
      end
    end
  end
end
# rubocop:enable Layout/LineLength
