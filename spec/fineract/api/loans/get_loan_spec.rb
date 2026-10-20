# frozen_string_literal: true

require "spec_helper"

RSpec.describe Fineract::Api::Loans::GetLoan do
  describe ".find" do
    let(:response_body) do
      {
        "id" => 1,
        "clientId" => 1,
        "loanProductId" => 1,
        "principal" => 10_000
      }.to_json
    end

    before do
      stub_request(:get, %r{/loans/\d+$})
        .to_return(status: 200, body: response_body, headers: {})
    end

    it "returns a loan" do
      result = described_class.find(1)

      expect(result.id).to eq(1)
      expect(result.principal).to eq(10_000)
    end
  end
end
