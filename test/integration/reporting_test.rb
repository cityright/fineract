# frozen_string_literal: true

require_relative "test_helper"

class ReportingIntegrationTest < IntegrationTest
  def test_reports_and_search_are_readable
    assert INTEGRATION_CLIENT.reporting.reports.list.success?
    assert INTEGRATION_CLIENT.search.query(query: "client", resource: "client").success?
  end
end
