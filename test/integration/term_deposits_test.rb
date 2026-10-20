# frozen_string_literal: true

require_relative "test_helper"

class TermDepositsIntegrationTest < IntegrationTest
  def test_deposit_products_are_readable
    assert INTEGRATION_CLIENT.fixed_deposits.products.list.success?
    assert INTEGRATION_CLIENT.recurring_deposits.products.list.success?
  end
end
