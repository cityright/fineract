# frozen_string_literal: true

require "spec_helper"

RSpec.describe Fineract::Api::Loans::RepayLoan do
  describe ".repay" do
    let(:response_body) do
      {
        "loanId" => 1,
        "resourceId" => 2,
        "changes" => {
          "transactionDate" => "01 January 2024",
          "transactionAmount" => "1000.00"
        }
      }.to_json
    end

    before do
      stub_request(:post, %r{/loans/\d+/transactions\?command=repayment$})
        .to_return(status: 200, body: response_body, headers: {})
    end

    it "records a repayment" do
      result = described_class.repay(
        id: 1,
        transactionDate: "01 January 2024",
        transactionAmount: 1000,
        paymentTypeId: 1,
        locale: "en",
        dateFormat: "dd MMMM yyyy"
      )

      expect(result.loan_id).to eq(1)
    end
  end
end
