# frozen_string_literal: true

require "json"
require "test_helper"

class EndpointConformanceTest < Minitest::Test
  REPORT = File.expand_path("../reports/endpoint-coverage.json", __dir__)

  def test_every_catalog_operation_is_registered_with_the_same_signature
    report = JSON.parse(File.read(REPORT))
    catalog = report.fetch("catalog_operations")
    registry = report.fetch("registry_operations")
    assert_operator catalog.length, :>, 0
    assert_equal catalog.length, report.fetch("summary").fetch("catalog_operations")
    assert_equal catalog.length, report.fetch("summary").fetch("registry_operations")
    assert_equal catalog.map { |operation| operation.reject { |key, _| key == "source" } }, registry
    assert_equal 0, report.fetch("summary").fetch("registry_gaps")
  end

  def test_each_catalog_operation_is_resource_covered_or_classified
    report = JSON.parse(File.read(REPORT))
    covered = report.fetch("resource_methods").map { |binding| binding.fetch("operation") }
    classified = report.fetch("deprecated_unsupported_operations").map { |operation| operation.fetch("operation") }
    catalog = report.fetch("catalog_operations").map { |operation| operation.fetch("operation") }

    assert_equal catalog.sort, (covered + classified).uniq.sort
    report.fetch("legacy_only_endpoints").each do |endpoint|
      assert_includes %w[implemented deprecated replaced intentionally_unavailable], endpoint.fetch("classification")
      refute_empty endpoint.fetch("reason")
    end
  end

  def test_generated_operations_facade_exposes_every_catalog_operation
    client = Fineract.client(adapter: [:test, Faraday::Adapter::Test::Stubs.new])
    operations = JSON.parse(File.read(REPORT)).fetch("catalog_operations")

    operations.each { |operation| assert_respond_to client.operations, operation.fetch("operation") }
  end

  def test_endpoint_identities_are_unique_and_do_not_embed_queries
    operations = JSON.parse(File.read(REPORT)).fetch("catalog_operations")
    identities = operations.map { |operation| operation.values_at("method", "path", "operation") }
    assert_equal identities.uniq, identities
    operations.each do |operation|
      refute_includes operation.fetch("path"), "?"
      assert_match(%r{\A/}, operation.fetch("path"))
    end
  end
end
