# frozen_string_literal: true

module Fineract
  module Api
    module FixedDeposits
      # @example FixedDeposits::PrematureClose
      #   Fineract::Api::FixedDeposits::PrematureClose.premature_close(id: 1)
      #
      class PrematureClose < AuthorisedBase
        post :premature_close, "/fixeddepositaccounts/:id?command=prematureClose", rubify_names: true
      end
    end
  end
end
