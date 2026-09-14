# frozen_string_literal: true

require "json"
require "test_helper"

class LoansTest < Minitest::Test
  def test_repayment_maps_snake_case_fields_and_command
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/loans/7/transactions") do |env|
      assert_equal "repayment", env.params["command"]
      assert_equal({ "transactionDate" => "2026-09-14", "transactionAmount" => 125, "paymentTypeId" => 3 }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).loans.transactions.repay(
      7, transaction_date: "2026-09-14", transaction_amount: 125, payment_type_id: 3
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_financial_commands_are_not_retried
    stubs = Faraday::Adapter::Test::Stubs.new
    attempts = 0
    stubs.post("/fineract-provider/api/v1/loans/7/transactions") do
      attempts += 1
      [503, {}, "busy"]
    end
    result = Fineract.client(adapter: [:test, stubs], retry_options: { max: 2 }).loans.transactions.disburse(7, transaction_date: "2026-09-14")
    assert_equal 503, result.status
    assert_equal 1, attempts
    stubs.verify_stubbed_calls
  end

  def test_structured_financial_error_is_preserved
    stubs = Faraday::Adapter::Test::Stubs.new
    payload = { "developerMessage" => "Insufficient funds", "errors" => [{ "parameterName" => "amount", "userMessageGlobalisationCode" => "error.insufficient" }] }
    stubs.post("/fineract-provider/api/v1/loans/7/transactions") { [400, { "Content-Type" => "application/json" }, JSON.generate(payload)] }
    error = Fineract.client(adapter: [:test, stubs]).loans.transactions.refund(7, amount: 99).failure
    assert_instance_of Fineract::ApiError, error
    assert_equal payload, error.payload
    assert_equal "Insufficient funds", error.developer_message
    assert_equal ["error.insufficient"], error.globalisation_codes
    assert_equal payload["errors"], error.parameter_errors
    stubs.verify_stubbed_calls
  end
end
