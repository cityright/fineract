# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::CreateLoan
      #   Fineract::Api::Loans::CreateLoan.create()
      #
      class CreateLoan < AuthorisedBase
        post :create, "/loans", rubify_names: true

        validates :clientId, presence: true, unless: -> { groupId.present? }
        validates :groupId, presence: true, unless: -> { clientId.present? }
        validates :productId, presence: true
        validates :principal, presence: true
        validates :loanTermFrequency, presence: true
        validates :loanTermFrequencyType, presence: true
        validates :numberOfRepayments, presence: true
        validates :repaymentEvery, presence: true
        validates :repaymentFrequencyType, presence: true
        validates :interestRatePerPeriod, presence: true
        validates :amortizationType, presence: true
        validates :interestType, presence: true
        validates :interestCalculationPeriodType, presence: true
        validates :expectedDisbursementDate, presence: true
        validates :submittedOnDate, presence: true
        validates :locale, presence: true
        validates :dateFormat, presence: true
      end
    end
  end
end
