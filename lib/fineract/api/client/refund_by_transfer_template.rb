# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::RefundByTransferTemplate
      #   Fineract::Api::Client::RefundByTransferTemplate.template()
      #
      class RefundByTransferTemplate < AuthorisedBase
        get :template, "/accounttransfers/templateRefundByTransfer", rubify_names: true
      end
    end
  end
end
