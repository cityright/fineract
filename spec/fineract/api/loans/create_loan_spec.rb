# frozen_string_literal: true

require "spec_helper"

RSpec.describe Fineract::Api::Loans::CreateLoan do
  describe ".create" do
    let(:response_body) do
      {
        "clientId" => 1,
        "loanId" => 2,
        "resourceId" => 2
      }.to_json
    end

    before do
      stub_request(:post, %r{/loans$})
        .to_return(status: 200, body: response_body, headers: {})
    end

    it "creates a new loan" do
      result = described_class.create(
        clientId: 1,
        productId: 1,
        principal: 10_000,
        loanTermFrequency: 12,
        loanTermFrequencyType: 2,
        numberOfRepayments: 12,
        repaymentEvery: 1,
        repaymentFrequencyType: 2,
        interestRatePerPeriod: 2,
        amortizationType: 1,
        interestType: 0,
        interestCalculationPeriodType: 1,
        expectedDisbursementDate: "01 January 2024",
        submittedOnDate: "01 January 2024",
        locale: "en",
        dateFormat: "dd MMMM yyyy"
      )

      expect(result.loan_id).to eq(2)
    end

    it "is invalid when required fields are missing" do
      loan = described_class.new({})
      expect(loan).not_to be_valid
    end
  end
end
