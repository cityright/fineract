# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::ListAccounts
      #   Fineract::Api::FixedDeposits::ListAccounts.all()
      #
      class ListAccounts < AuthorisedBase
        get :all, "/fixeddepositaccounts", rubify_names: true
      end
    end
  end
end
