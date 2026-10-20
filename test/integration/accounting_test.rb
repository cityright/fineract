# frozen_string_literal: true

require_relative "test_helper"

class AccountingIntegrationTest < IntegrationTest
  def test_general_ledger_accounts_are_readable
    result = INTEGRATION_CLIENT.accounting.gl_accounts.list
    assert result.success?, result.failure.inspect
  end
end
