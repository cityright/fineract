# frozen_string_literal: true

require "json"
require "test_helper"

class LoanProductsTest < Minitest::Test
  def test_product_create_maps_wire_fields_and_is_not_retried
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/loanproducts") do |env|
      assert_equal({ "name" => "Working loan", "shortName" => "WL", "currencyCode" => "KES", "interestRatePerPeriod" => 2.5 }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).loan_products.create(
      name: "Working loan", short_name: "WL", currency_code: "KES", interest_rate_per_period: 2.5
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_product_mix_maps_restricted_products
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/loanproducts/4/productmix") do |env|
      assert_equal({ "restrictedProducts" => [7, 8] }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).loan_products.product_mixes.create(4, restricted_products: [7, 8])
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_application_submission_maps_date_amount_and_command
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/loans") do |env|
      assert_equal "submit", env.params["command"]
      body = JSON.parse(env.body)
      assert_equal 3, body["clientId"]
      assert_equal 1000, body["principal"]
      assert_equal "2026-09-14", body["submittedOnDate"]
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    result = Fineract.client(adapter: [:test, stubs]).loans.submit(
      client_id: 3, product_id: 4, principal: 1000, submitted_on_date: "2026-09-14"
    )
    assert result.success?
    stubs.verify_stubbed_calls
  end

  def test_invalid_application_does_not_make_a_request
    stubs = Faraday::Adapter::Test::Stubs.new
    result = Fineract.client(adapter: [:test, stubs]).loans.submit(client_id: 0, product_id: 4, principal: 0, submitted_on_date: "")
    assert_instance_of Fineract::ValidationError, result.failure
    assert_empty stubs.instance_variable_get(:@stack)
  end
end
