# frozen_string_literal: true

require_relative "test_helper"

class EntityMetadataIntegrationTest < Minitest::Test
  def test_entity_metadata_is_readable
    assert INTEGRATION_CLIENT.entity_datatable_checks.list.success?
    assert INTEGRATION_CLIENT.entity_datatable_checks.template.success?
    assert INTEGRATION_CLIENT.entity_field_configuration.retrieve("m_client").success?
  end
end
