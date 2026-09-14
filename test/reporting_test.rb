# frozen_string_literal: true

require "json"
require "test_helper"

class ReportingTest < Minitest::Test
  def test_report_create_maps_fields_and_is_not_retried
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/reports") do |env|
      assert_equal({ "reportName" => "Portfolio", "reportSql" => "select 1", "reportType" => "Table" }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).reporting.reports.create(report_name: "Portfolio", report_sql: "select 1", report_type: "Table")
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_runner_supports_csv_response_and_query_mapping
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/runreports/Portfolio") do |env|
      assert_equal "csv", env.params["output-type"]
      assert_equal "3", env.params["R_officeId"]
      [200, { "Content-Type" => "text/csv" }, "id,name\n1,Jane\n"]
    end
    result = Fineract.client(adapter: [:test, stubs]).reporting.runner.run("Portfolio", format: :csv, output_type: "csv", office_id: 3)
    assert_equal "id,name\n1,Jane\n", result.data
    stubs.verify_stubbed_calls
  end

  def test_search_and_advanced_search_map_fields
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/search") do |env|
      assert_equal "Jane", env.params["query"]
      assert_equal "clients", env.params["resource"]
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    stubs.post("/fineract-provider/api/v1/search/advance") do |env|
      body = JSON.parse(env.body)
      assert_equal "2026-01-01", body["loanFromDate"]
      assert_equal 100, body["minOutstandingAmount"]
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    client = Fineract.client(adapter: [:test, stubs])
    assert client.search.query(query: "Jane", resource: "clients").success?
    assert client.search.advanced(loan_from_date: "2026-01-01", min_outstanding_amount: 100).success?
    stubs.verify_stubbed_calls
  end

  def test_invalid_report_does_not_make_a_request
    stubs = Faraday::Adapter::Test::Stubs.new
    result = Fineract.client(adapter: [:test, stubs]).reporting.reports.create(report_name: "", report_sql: "", report_type: "Table")
    assert_instance_of Fineract::ValidationError, result.failure
    assert_empty stubs.instance_variable_get(:@stack)
  end
end
