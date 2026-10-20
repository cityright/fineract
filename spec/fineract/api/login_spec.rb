# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require "spec_helper"

RSpec.describe Fineract::Api::Login do
  describe ".create" do
    let(:login) { build(:login) }
    let(:login_url) do
      "#{ENV["FINERACT_BASE_URL"]}/fineract-provider/api/v1/authentication?username=#{ENV["FINERACT_API_USERNAME"]}&password=#{ENV["FINERACT_API_PASSWORD"]}"
    end

    context "when the credentials are valid" do
      before do
        stub_request(:post, login_url)
          .to_return(status: 200, body: login.to_json, headers: {})
      end

      it "passes authentication" do
        result = described_class.create(
          username: ENV["FINERACT_API_USERNAME"],
          password: ENV["FINERACT_API_PASSWORD"]
        )

        expect(result.to_hash).to eq(login.to_hash)
      end
    end

    context "when the credentials are invalid" do
      before do
        stub_request(:post, login_url)
          .to_return(
            status: 500,
            body: {
              "requestId": "27470-9278829-1",
              "errorCode": "500.001.1001",
              "errorMessage": "Wrong credentials"
            }.to_json,
            headers: {}
          )
      end

      it "raises a HTTP server exception" do
        expect {
          described_class.create(
            username: ENV["FINERACT_API_USERNAME"],
            password: ENV["FINERACT_API_PASSWORD"]
          )
        }.to raise_exception(Flexirest::HTTPServerException)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
