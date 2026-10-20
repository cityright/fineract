# frozen_string_literal: true

require_relative "test_helper"

class SharesIntegrationTest < Minitest::Test
  def test_share_products_and_transfer_templates_are_readable
    assert INTEGRATION_CLIENT.shares.products.list.success?
    assert INTEGRATION_CLIENT.account_transfers.template.success?
  end
end
