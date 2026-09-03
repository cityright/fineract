# frozen_string_literal: true

require "json"
require "test_helper"

class EndpointConformanceTest < Minitest::Test
  REPORT = File.expand_path("../reports/endpoint-coverage.json", __dir__)

  def test_every_declared_endpoint_is_present_and_conformant
    report = JSON.parse(File.read(REPORT))
    operations = report.fetch("operations")
    summary = report.fetch("summary")

    assert_operator operations.length, :>, 0
    assert_equal operations.length, summary.fetch("declared_operations")
    assert_equal operations.length, summary.fetch("conformant_operations")
    assert_equal 100.0, summary.fetch("coverage_percent")
  end

  def test_endpoint_identities_are_unique_and_do_not_embed_queries
    operations = JSON.parse(File.read(REPORT)).fetch("operations")
    identities = operations.map do |operation|
      operation.values_at("method", "path", "operation")
    end

    assert_equal identities.uniq, identities
    operations.each do |operation|
      refute_includes operation.fetch("path"), "?"
      assert_match(%r{\A/}, operation.fetch("path"))
    end
  end
end
