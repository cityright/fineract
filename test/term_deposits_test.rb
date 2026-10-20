# frozen_string_literal: true

require "json"
require "test_helper"

class TermDepositsTest < Minitest::Test
  def test_fixed_product_uses_explicit_wire_mapping
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/fixeddepositproducts") do |env|
      assert_equal(
        { "name" => "12 month FD", "currencyCode" => "KES", "minDepositAmount" => 1000 }, JSON.parse(env.body)
      )
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).fixed_deposits.products.create(
      name: "12 month FD", currency_code: "KES", min_deposit_amount: 1000
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_invalid_account_does_not_make_a_request
    stubs = Faraday::Adapter::Test::Stubs.new
    result = Fineract.client(adapter: [:test, stubs]).recurring_deposits.accounts.create(client_id: 0, product_id: 2)
    assert_instance_of Fineract::ValidationError, result.failure
    assert_empty stubs.instance_variable_get(:@stack)
  end

  def test_recurring_transaction_is_a_non_retryable_financial_mutation
    stubs = Faraday::Adapter::Test::Stubs.new
    attempts = 0
    stubs.post("/fineract-provider/api/v1/recurringdepositaccounts/7/transactions") do |env|
      attempts += 1
      assert_equal({ "amount" => 50, "transactionDate" => "2026-09-14" }, JSON.parse(env.body))
      [503, {}, "busy"]
    end
    result = Fineract.client(adapter: [:test, stubs]).recurring_deposits.transactions.create(
      7, amount: 50, transaction_date: "2026-09-14"
    )
    assert_equal 503, result.status
    assert_equal 1, attempts
    stubs.verify_stubbed_calls
  end

  def test_fixed_transaction_maps_account_path_and_fields
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/fixeddepositaccounts/9/transactions") do |env|
      assert_equal({ "amount" => 125, "transactionDate" => "2026-09-14" }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).fixed_deposits.transactions.create(
      9, amount: 125, transaction_date: "2026-09-14"
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_recurring_closure_template_uses_the_contract_operation
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/recurringdepositaccounts/9/template") do |env|
      assert_equal "close", env.params["command"]
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).recurring_deposits.accounts.closure_template(9, command: "close")
    assert result.success?
    stubs.verify_stubbed_calls
  end
end
