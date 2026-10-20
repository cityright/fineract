# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::CreateAccount
      #   Fineract::Api::FixedDeposits::CreateAccount.create()
      #
      class CreateAccount < AuthorisedBase
        post :create, "/fixeddepositaccounts", rubify_names: true
      end
    end
  end
end
