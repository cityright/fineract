# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::UpdateAccount
      #   Fineract::Api::FixedDeposits::UpdateAccount.save(id: 1)
      #
      class UpdateAccount < AuthorisedBase
        put :save, "/fixeddepositaccounts/:id", rubify_names: true
      end
    end
  end
end
