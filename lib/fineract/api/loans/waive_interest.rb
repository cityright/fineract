# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::WaiveInterest
      #   Fineract::Api::Loans::WaiveInterest.waive(id: 1)
      #
      class WaiveInterest < AuthorisedBase
        post :waive, "/loans/:id/transactions?command=waiveInterest", rubify_names: true
      end
    end
  end
end
