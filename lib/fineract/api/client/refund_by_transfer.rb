# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::RefundByTransfer
      #   Fineract::Api::Client::RefundByTransfer.refund()
      #
      class RefundByTransfer < AuthorisedBase
        post :refund, "/accounttransfers/refundByTransfer", rubify_names: true
      end
    end
  end
end
