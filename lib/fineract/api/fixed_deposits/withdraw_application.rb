# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::WithdrawApplication
      #   Fineract::Api::FixedDeposits::WithdrawApplication.withdraw(id: 1)
      #
      class WithdrawApplication < AuthorisedBase
        post :withdraw, "/fixeddepositaccounts/:id?command=withdraw", rubify_names: true
      end
    end
  end
end
