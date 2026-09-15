# frozen_string_literal: true

require "json"
require "test_helper"

class CashManagementTest < Minitest::Test
  def test_teller_create_maps_fields
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/tellers") do |env|
      assert_equal({ "name" => "Main", "officeId" => 1, "startDate" => "2026-09-15" }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).tellers.create(name: "Main", office_id: 1, start_date: "2026-09-15")
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_allocate_cash_is_explicitly_non_retryable
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/tellers/2/cashiers/3/allocate") do |env|
      assert_equal({ "currencyCode" => "KES", "txnAmount" => 100, "txnDate" => "2026-09-15" }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).tellers.cashiers_resource(2).allocate(
      3, currency_code: "KES", txn_amount: 100, txn_date: "2026-09-15"
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_invalid_settlement_does_not_make_a_request
    stubs = Faraday::Adapter::Test::Stubs.new
    result = Fineract.client(adapter: [:test, stubs]).cash_management.cashiers_resource(2).settle(
      3, currency_code: "KES", txn_amount: 0, txn_date: "2026-09-15"
    )
    assert_instance_of Fineract::ValidationError, result.failure
    assert_empty stubs.instance_variable_get(:@stack)
  end

  def test_cash_management_preserves_structured_financial_error
    stubs = Faraday::Adapter::Test::Stubs.new
    payload = { "developerMessage" => "Insufficient cash", "errors" => [{ "userMessageGlobalisationCode" => "error.cash.insufficient" }] }
    stubs.post("/fineract-provider/api/v1/tellers/2/cashiers/3/settle") { [400, { "Content-Type" => "application/json" }, JSON.generate(payload)] }
    error = Fineract.client(adapter: [:test, stubs]).cash_management.cashiers_resource(2).settle(
      3, currency_code: "KES", txn_amount: 100, txn_date: "2026-09-15"
    ).failure
    assert_instance_of Fineract::ApiError, error
    assert_equal payload, error.payload
    assert_equal "Insufficient cash", error.developer_message
    assert_equal ["error.cash.insufficient"], error.globalisation_codes
    stubs.verify_stubbed_calls
  end
end
