# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::RejectTransfer
      #   Fineract::Api::Client::RejectTransfer.create(id:10, "note":"We cannot accept tranfers of clients having loans with less than 1 repayment left")
      #
      #
      class RejectTransfer < AuthorisedBase
        post :reject, "/clients/:id?command=rejectTransfer", rubify_names: true
      end
    end
  end
end
# rubocop:enable Layout/LineLength
