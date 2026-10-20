# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimWithdraw
      #   Fineract::Api::Savings::GsimWithdraw.withdraw(id: 1)
      #
      class GsimWithdraw < AuthorisedBase
        post :withdraw, "/savingsaccounts/gsimcommands/:id?command=withdrawnByApplicant", rubify_names: true
      end
    end
  end
end
