# frozen_string_literal: true

require "json"
require "test_helper"

class SharesTest < Minitest::Test
  def test_share_product_maps_fields
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/products/shares") do |env|
      assert_equal({ "name" => "Member shares", "shortName" => "MS", "currencyCode" => "KES", "unitPrice" => 100 }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).shares.products.create(name: "Member shares", short_name: "MS", currency_code: "KES", unit_price: 100)
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_share_account_command_maps_requested_shares_and_is_not_retried
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/accounts/shares/8") do |env|
      assert_equal "approve", env.params["command"]
      assert_equal({ "requestedShares" => 20 }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).shares.accounts.approve(8, requested_shares: 20)
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_dividend_maps_date
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/shareproduct/3/dividend") do |env|
      assert_equal "2026-09-14", env.body
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).shares.dividends.create(3, dividend_date: "2026-09-14")
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_invalid_share_account_does_not_make_a_request
    stubs = Faraday::Adapter::Test::Stubs.new
    result = Fineract.client(adapter: [:test, stubs]).shares.accounts.create(client_id: 0, product_id: 2, application_date: "", requested_shares: 0)
    assert_instance_of Fineract::ValidationError, result.failure
    assert_empty stubs.instance_variable_get(:@stack)
  end
end
