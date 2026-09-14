# frozen_string_literal: true

require_relative "test_helper"

class OrganizationIntegrationTest < Minitest::Test
  def test_reference_data_is_readable
    assert INTEGRATION_CLIENT.organization.staff.list.success?
    assert INTEGRATION_CLIENT.organization.currencies.list.success?
    assert INTEGRATION_CLIENT.organization.working_days.list.success?
  end
end
