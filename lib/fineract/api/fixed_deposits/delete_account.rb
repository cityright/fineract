# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::DeleteAccount
      #   Fineract::Api::FixedDeposits::DeleteAccount.remove(id: 1)
      #
      class DeleteAccount < AuthorisedBase
        delete :remove, "/fixeddepositaccounts/:id", rubify_names: true
      end
    end
  end
end
