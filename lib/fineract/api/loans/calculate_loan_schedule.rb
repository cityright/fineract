# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::CalculateLoanSchedule
      #   Fineract::Api::Loans::CalculateLoanSchedule.calculate()
      #
      class CalculateLoanSchedule < AuthorisedBase
        post :calculate, "/loans?calculateLoanSchedule", rubify_names: true
      end
    end
  end
end
