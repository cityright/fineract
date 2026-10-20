# frozen_string_literal: true

require_relative "test_helper"

class SavingsIntegrationTest < IntegrationTest
  def test_savings_products_and_accounts_are_readable
    assert INTEGRATION_CLIENT.savings.products.list.success?
    assert INTEGRATION_CLIENT.savings.accounts.list.success?
  end
end
