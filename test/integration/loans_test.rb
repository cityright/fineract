# frozen_string_literal: true

require_relative "test_helper"

class LoansIntegrationTest < IntegrationTest
  def test_loan_reads_and_schedule_command_are_available
    result = INTEGRATION_CLIENT.loans.list(limit: 1)
    assert result.success?, result.failure.inspect
  end
end
