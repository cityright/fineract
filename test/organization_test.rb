# frozen_string_literal: true

require "json"
require "test_helper"

class OrganizationTest < Minitest::Test
  def test_staff_create_maps_snake_case_fields_and_validates_contract
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/staff") do |env|
      assert_equal({ "firstname" => "Jane", "lastname" => "Doe", "officeId" => 3, "isLoanOfficer" => true }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    client = Fineract.client(adapter: [:test, stubs])
    assert_equal 200, client.organization.staff.create(firstname: "Jane", lastname: "Doe", office_id: 3, is_loan_officer: true).status
    invalid = client.organization.staff.create(firstname: "Jane", lastname: "Doe", office_id: 0)
    assert_instance_of Fineract::ValidationError, invalid.failure
    stubs.verify_stubbed_calls
  end

  def test_code_values_map_nested_paths
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.put("/fineract-provider/api/v1/codes/4/codevalues/9") do |env|
      assert_equal({ "isActive" => false, "name" => "Former" }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    assert_equal 200, Fineract.client(adapter: [:test, stubs]).organization.codes.update_code_value(4, 9, is_active: false, name: "Former").status
    stubs.verify_stubbed_calls
  end
end
