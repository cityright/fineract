# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimDeposit
      #   Fineract::Api::Savings::GsimDeposit.gsim_deposit(id: 1)
      #
      class GsimDeposit < AuthorisedBase
        post :gsim_deposit, "/savingsaccounts/:savingsId/transactions?command=gsimDeposit", rubify_names: true
      end
    end
  end
end
