# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::GetAccount
      #   Fineract::Api::FixedDeposits::GetAccount.find(id: 1)
      #
      class GetAccount < AuthorisedBase
        get :find, "/fixeddepositaccounts/:id", rubify_names: true
      end
    end
  end
end
