# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::ActivateAccount
      #   Fineract::Api::FixedDeposits::ActivateAccount.activate(id: 1)
      #
      class ActivateAccount < AuthorisedBase
        post :activate, "/fixeddepositaccounts/:id?command=activate", rubify_names: true
      end
    end
  end
end
