# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Client
      # @example Client::WithdrawClient
      # Fineract::Api::Client::WithdrawClient.create(id: 10, "withdrawalDate":"28 November 2014","withdrawalReasonId":17,"locale":"en","dateFormat":"dd MMMM yyyy")
      #
      class WithdrawClient < AuthorisedBase
        post :create, "/clients/:id?command=withdraw", rubify_names: true
      end
    end
  end
end
# rubocop:enable Layout/LineLength
