# frozen_string_literal: true

require_relative "test_helper"

class SpecialistLendingIntegrationTest < Minitest::Test
  def test_specialist_resources_are_available_against_the_pinned_server
    result = INTEGRATION_CLIENT.working_capital_loan_products.list
    assert result.success?, result.failure.inspect
  end
end
