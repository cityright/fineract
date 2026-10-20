# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::CloseAccount
      #   Fineract::Api::FixedDeposits::CloseAccount.close(id: 1)
      #
      class CloseAccount < AuthorisedBase
        post :close, "/fixeddepositaccounts/:id?command=close", rubify_names: true
      end
    end
  end
end
