# frozen_string_literal: true

require "json"
require "test_helper"

class AccountTransfersTest < Minitest::Test
  def test_transfer_maps_accounts_money_and_date
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/accounttransfers") do |env|
      body = JSON.parse(env.body)
      assert_equal "10", body["fromAccountId"]
      assert_equal "11", body["toAccountId"]
      assert_equal 250, body["transferAmount"]
      assert_equal "2026-09-14", body["transferDate"]
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).account_transfers.create(
      from_account_id: "10", to_account_id: "11", transfer_amount: 250, transfer_date: "2026-09-14"
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_transfer_mutation_is_not_retried
    stubs = Faraday::Adapter::Test::Stubs.new
    attempts = 0
    stubs.post("/fineract-provider/api/v1/accounttransfers") do
      attempts += 1
      [503, {}, "busy"]
    end
    result = Fineract.client(adapter: [:test, stubs], retry_options: { max: 2 }).account_transfers.create(
      from_account_id: "10", to_account_id: "11", transfer_amount: 250, transfer_date: "2026-09-14"
    )
    assert_equal 503, result.status
    assert_equal 1, attempts
    stubs.verify_stubbed_calls
  end
end
