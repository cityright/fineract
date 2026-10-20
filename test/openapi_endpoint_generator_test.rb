# frozen_string_literal: true

require "test_helper"
require "fineract/openapi_endpoint_generator"

class OpenapiEndpointGeneratorTest < Minitest::Test
  RecordingClient = Struct.new(:calls) do
    def call(operation, **options)
      calls << [operation, options]
    end
  end

  def test_generated_operations_warn_for_each_deprecated_operation
    operations = Fineract::GeneratedOperations.new(RecordingClient.new([]))
    deprecated = Fineract::OperationCatalog.default.each.select(&:deprecated)

    _stdout, stderr = capture_io do
      deprecated.each { |operation| operations.public_send(operation.name) }
    end

    assert_equal 6, deprecated.length
    deprecated.each do |operation|
      assert_includes stderr, "Fineract::GeneratedOperations##{operation.name}"
      assert_includes stderr, "#{operation.method.to_s.upcase} #{operation.path}"
    end
  end

  def test_stable_generation_preserves_commands_multipart_security_and_deprecation
    operations = generator.operations
    assert_equal operations, generator.operations

    command = operations.find { |operation| operation["operation"] == "runJob" }
    parameters = command.fetch("parameters")
    query_names = parameters.select { |parameter| parameter["in"] == "query" }.map { |parameter| parameter["name"] }
    path_names = parameters.select { |parameter| parameter["in"] == "path" }.map { |parameter| parameter["name"] }
    header_names = parameters.select { |parameter| parameter["in"] == "header" }.map { |parameter| parameter["name"] }
    assert_equal ["command"], query_names
    assert_equal ["jobId"], path_names
    assert_equal ["X-Trace-Id"], header_names

    upload = operations.find { |operation| operation["operation"] == "uploadDocument" }
    assert_includes upload.fetch("request_media_types"), "multipart/form-data"
    assert_equal [{ "tenantid" => [] }], upload.fetch("security")

    retired = operations.find { |operation| operation["operation"] == "retiredOperation" }
    assert retired.fetch("deprecated")
  end

  def test_overrides_resolve_missing_duplicate_and_unsuitable_names
    document = fixture_document.merge(
      "paths" => {
        "/v1/a" => { "get" => { "operationId" => "duplicate", "responses" => {} } },
        "/v1/b" => { "get" => { "operationId" => "duplicate", "responses" => {} } },
        "/v1/c" => { "post" => { "operationId" => "not-valid", "responses" => {} } },
        "/v1/d" => { "get" => { "responses" => {} } }
      }
    )
    overrides = { "operations" => {
      "GET /v1/a" => { "operation_id" => "first_operation" },
      "GET /v1/b" => { "operation_id" => "second_operation" },
      "POST /v1/c" => { "operation_id" => "third_operation" },
      "GET /v1/d" => { "operation_id" => "fourth_operation" }
    } }

    assert_equal %w[first_operation fourth_operation second_operation third_operation],
                 Fineract::OpenapiEndpointGenerator.new(document: document, overrides: overrides).operations.map { |operation| operation.fetch("operation") }.sort
  end

  def test_invalid_or_unused_override_fails_loudly
    error = assert_raises(ArgumentError) do
      Fineract::OpenapiEndpointGenerator.new(document: fixture_document, overrides: { "GET /v1/unknown" => { "operation_id" => "nope" } }).operations
    end
    assert_match(/do not match/, error.message)
  end

  def test_client_validation_enforces_required_parameters_and_basic_types
    operation = Fineract::OperationCatalog::Operation.new(
      "fixture", :post, "/fixtures/{id}", [],
      [{ "name" => "id", "in" => "path", "required" => true, "schema" => { "type" => "integer" } },
       { "name" => "active", "in" => "query", "required" => true, "schema" => { "type" => "boolean" } }],
      ["application/json"], { "application/json" => { "type" => "object", "required" => ["name"] } },
      ["application/json"], [], true, false
    )
    client = Fineract.client(adapter: [:test, Faraday::Adapter::Test::Stubs.new])

    error = assert_raises(Fineract::ValidationError) { client.send(:validate_inputs!, operation, {}, {}, {}, nil) }
    assert_match(/path parameter: id/, error.message)
    error = assert_raises(Fineract::ValidationError) { client.send(:validate_inputs!, operation, { id: "1" }, { active: "yes" }, {}, { name: "ok" }) }
    assert_match(/integer/, error.message)
    error = assert_raises(Fineract::ValidationError) { client.send(:validate_inputs!, operation, { id: 1 }, { active: true }, {}, {}) }
    assert_match(/required body/, error.message)
  end

  def test_checked_in_definitions_are_deeply_immutable
    definition = Fineract::GeneratedEndpointDefinitions::RAW.first
    assert_predicate Fineract::GeneratedEndpointDefinitions::RAW, :frozen?
    assert_predicate definition, :frozen?
    assert_predicate definition.fetch("parameters"), :frozen?
  end

  private

  def generator
    @generator ||= Fineract::OpenapiEndpointGenerator.new(document: fixture_document)
  end

  def fixture_document
    {
      "security" => [{ "tenantid" => [] }],
      "paths" => {
        "/v1/jobs/{jobId}" => { "parameters" => [{ "name" => "jobId", "in" => "path", "required" => true, "schema" => { "type" => "integer" } }], "post" => { "operationId" => "runJob", "parameters" => [{ "name" => "command", "in" => "query", "schema" => { "type" => "string" } }, { "name" => "X-Trace-Id", "in" => "header", "schema" => { "type" => "string" } }], "responses" => {} } },
        "/v1/documents" => { "post" => { "operationId" => "uploadDocument", "requestBody" => { "content" => { "multipart/form-data" => { "schema" => { "type" => "object" } } } }, "responses" => {} } },
        "/v1/retired" => { "get" => { "operationId" => "retiredOperation", "deprecated" => true, "security" => [{ "basicAuth" => [] }], "responses" => {} } }
      }
    }
  end
end
