# frozen_string_literal: true

require "json"
require "test_helper"

class SpecialistLendingTest < Minitest::Test
  def test_loan_collateral_maps_path_and_fields
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/loans/7/collaterals") do |env|
      assert_equal({ "type" => "vehicle", "marketValue" => 1000 }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).loans.collaterals.create(7, type: "vehicle", market_value: 1000)
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_guarantor_and_post_dated_check_resources_are_exposed
    client = Fineract.client(adapter: [:test, Faraday::Adapter::Test::Stubs.new])
    assert_instance_of Fineract::LoanGuarantors, client.loans.guarantors
    assert_instance_of Fineract::PostDatedChecks, client.loans.post_dated_checks
    assert_instance_of Fineract::Glim, client.glim
    assert_instance_of Fineract::Gsim, client.gsim
    assert_instance_of Fineract::WorkingCapitalLoans, client.working_capital_loans
  end
end
