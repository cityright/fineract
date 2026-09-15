# frozen_string_literal: true

require "json"
require "test_helper"

class EntityMetadataTest < Minitest::Test
  def client_with(stubs, **options)
    Fineract.client(adapter: [:test, stubs], **options)
  end

  def test_entity_datatable_checks_preserve_wire_keys_and_query_parameters
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/entityDatatableChecks") do |env|
      assert_equal({ "status" => "100", "entity" => "m_loan", "productId" => "7", "offset" => "0", "limit" => "25" }, env.params)
      [200, { "Content-Type" => "application/json" }, '{"pageItems":[]}']
    end
    stubs.post("/fineract-provider/api/v1/entityDatatableChecks") do |env|
      assert_equal({ "entity" => "m_loan", "status" => 100, "datatableName" => "Additional Details", "productId" => 7 }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, '{"resourceId":8}']
    end

    client = client_with(stubs)
    assert client.entity_datatable_checks.list(status: 100, entity: "m_loan", product_id: 7, offset: 0, limit: 25).success?
    assert client.entity_datatable_checks.create(entity: "m_loan", status: 100, datatable_name: "Additional Details", product_id: 7).success?
    stubs.verify_stubbed_calls
  end

  def test_entity_field_configuration_uses_entity_path
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/fieldconfiguration/m_loan") do
      [200, { "Content-Type" => "application/json" }, '[{"fieldConfigurationId":3,"isEnabled":true}]']
    end

    result = client_with(stubs).entity_field_configuration.find("m_loan")
    assert result.success?
    assert_equal 3, result.value!.data.first["fieldConfigurationId"]
    stubs.verify_stubbed_calls
  end

  def test_create_contract_errors_are_structured_and_do_not_transport
    stubs = Faraday::Adapter::Test::Stubs.new
    result = client_with(stubs).entity_datatable_checks.create(entity: "m_loan", status: 100, datatable_name: "")

    assert_instance_of Fineract::Failure, result
    assert_instance_of Fineract::ValidationError, result.failure
    refute_nil result.failure.details
    stubs.verify_stubbed_calls
  end

  def test_delete_rejects_non_positive_identifier
    stubs = Faraday::Adapter::Test::Stubs.new
    result = client_with(stubs).entity_datatable_checks.delete(0)

    assert_instance_of Fineract::Failure, result
    assert_instance_of Fineract::ValidationError, result.failure
    stubs.verify_stubbed_calls
  end
end
