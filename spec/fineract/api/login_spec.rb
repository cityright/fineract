# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fineract::Api::Login do
  describe '.create' do
    let(:login) { build(:login) }
    # let(:login_credentials) { build(:login_credentials) }
    let(:stub_fineract_login_request) do
      stub_fineract_request(:get, "/authentication?username=#{ENV["FINERACT_API_USERNAME"]}&password=#{ENV["FINERACT_API_PASSWORD"]}").with(
        headers: basic_headers_with_login(login)
      )
    end

    context 'when the credentials are valid' do
      before do
        stub_fineract_login_request.to_return(status: 200, body: login.to_json, headers: {})
      end

      xit 'passes authentication' do
        result = described_class.create

        expect(result.to_hash).to eq(login.to_hash)
      end
    end

    context 'when the credentials are invalid' do
      before do
        stub_fineract_login_request.to_return(
          status: 500,
          body: {
            "requestId": '27470-9278829-1',
            "errorCode": '500.001.1001',
            "errorMessage": 'Wrong credentials'
          }.to_json,
          headers: {}
        )
      end

      xit 'is raises a HTTP server exception' do
        expect { described_class.create }.to raise_exception(Flexirest::HTTPServerException)
      end
    end
  end
end
