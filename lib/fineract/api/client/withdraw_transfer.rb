# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::WithdrawTransfer
      #   Fineract::Api::Client::WithdrawTransfer.create(id:10, "note":"Sorry, data entry error")
      #
      #
      class WithdrawTransfer < AuthorisedBase
        post :create, "/clients/:id?command=withdrawTransfer", rubify_names: true
      end
    end
  end
end
