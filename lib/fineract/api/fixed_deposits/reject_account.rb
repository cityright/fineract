# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::RejectAccount
      #   Fineract::Api::FixedDeposits::RejectAccount.reject(id: 1)
      #
      class RejectAccount < AuthorisedBase
        post :reject, "/fixeddepositaccounts/:id?command=reject", rubify_names: true
      end
    end
  end
end
