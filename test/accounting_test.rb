# frozen_string_literal: true

require "json"
require "test_helper"

class AccountingTest < Minitest::Test
  def test_gl_account_maps_snake_case_and_uses_non_retryable_mutation
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/glaccounts") do |env|
      assert_equal(
        { "name" => "Cash", "glCode" => "100001", "manualEntriesAllowed" => true, "type" => 1,
          "usage" => 1 }, JSON.parse(env.body)
      )
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).accounting.gl_accounts.create(
      name: "Cash", gl_code: "100001", manual_entries_allowed: true, type: 1, usage: 1
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_journal_entry_maps_nested_debits_and_credits
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/journalentries") do |env|
      body = JSON.parse(env.body)
      assert_equal "2026-09-14", body["transactionDate"]
      assert_equal({ "glAccountId" => 4, "amount" => 20 }, body["debits"].first)
      assert_equal({ "glAccountId" => 5, "amount" => 20 }, body["credits"].first)
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).accounting.journal_entries.create(
      office_id: 1, transaction_date: "2026-09-14",
      debits: [{ gl_account_id: 4, amount: 20 }], credits: [{ gl_account_id: 5, amount: 20 }]
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_invalid_account_does_not_make_a_request
    stubs = Faraday::Adapter::Test::Stubs.new
    result = Fineract.client(adapter: [:test, stubs]).accounting.gl_accounts.create(name: "Cash", gl_code: "100001",
                                                                                    type: 0)
    assert_instance_of Fineract::ValidationError, result.failure
    assert_empty stubs.instance_variable_get(:@stack)
  end

  def test_accrual_failure_keeps_structured_error
    stubs = Faraday::Adapter::Test::Stubs.new
    payload = { "developerMessage" => "Period is closed",
                "errors" => [{ "userMessageGlobalisationCode" => "error.period.closed" }] }
    stubs.post("/fineract-provider/api/v1/runaccruals") do
      [400, { "Content-Type" => "application/json" }, JSON.generate(payload)]
    end
    error = Fineract.client(adapter: [:test, stubs]).accounting.accruals.run(till_date: "2026-09-14").failure
    assert_instance_of Fineract::ApiError, error
    assert_equal payload, error.payload
    assert_equal "Period is closed", error.developer_message
    assert_equal ["error.period.closed"], error.globalisation_codes
    stubs.verify_stubbed_calls
  end
end
