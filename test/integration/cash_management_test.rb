# frozen_string_literal: true

require_relative "test_helper"

class CashManagementIntegrationTest < Minitest::Test
  def test_tellers_are_readable
    result = INTEGRATION_CLIENT.cash_management.list
    assert result.success?, result.failure.inspect
  end

  def test_cashiers_are_readable
    result = INTEGRATION_CLIENT.cash_management.cashiers.list
    assert result.success?, result.failure.inspect
  end
end
