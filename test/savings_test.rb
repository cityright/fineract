# frozen_string_literal: true

require "json"
require "test_helper"

class SavingsTest < Minitest::Test
  def test_product_and_account_use_explicit_wire_mappings
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/savingsproducts") do |env|
      assert_equal({ "name" => "Daily Saver", "shortName" => "DS", "currencyCode" => "KES" }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    stubs.post("/fineract-provider/api/v1/savingsaccounts") do |env|
      body = JSON.parse(env.body)
      assert_equal 7, body["clientId"]
      assert_equal 3, body["productId"]
      assert_equal({ "name" => "Amina", "accountNumber" => "123" }, body["beneficiaries"].first)
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    client = Fineract.client(adapter: [:test, stubs])
    assert client.savings.products.create(name: "Daily Saver", short_name: "DS", currency_code: "KES").success?
    assert client.savings.accounts.create(client_id: 7, product_id: 3, beneficiaries: [{ name: "Amina", account_number: "123" }]).success?
    stubs.verify_stubbed_calls
  end

  def test_financial_savings_transaction_is_not_retried
    stubs = Faraday::Adapter::Test::Stubs.new
    attempts = 0
    stubs.post("/fineract-provider/api/v1/savingsaccounts/8/transactions") { attempts += 1; [503, {}, "busy"] }
    result = Fineract.client(adapter: [:test, stubs], retry_options: { max: 2 }).savings.transactions.create(8, amount: 25)
    assert_equal 503, result.status
    assert_equal 1, attempts
    stubs.verify_stubbed_calls
  end

  def test_standing_instruction_maps_fields
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/standinginstructions") do |env|
      assert_equal({ "fromAccountId" => 8, "toAccountId" => 9, "transferType" => 1, "validFrom" => "2026-09-15" }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).savings.standing_instructions.create(from_account_id: 8, to_account_id: 9, transfer_type: 1, valid_from: "2026-09-15")
    assert result.success?
    stubs.verify_stubbed_calls
  end
end
