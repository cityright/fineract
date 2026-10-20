# frozen_string_literal: true

require "json"
require "test_helper"

class SecurityAdministrationTest < Minitest::Test
  def client_with(stubs)
    Fineract.client(adapter: [:test, stubs])
  end

  def test_user_lifecycle_maps_snake_case_fields_and_path
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/fineract-provider/api/v1/users") do |env|
      assert_equal({ "firstname" => "Jane", "password" => "secret", "repeatPassword" => "secret" },
                   JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, '{"resourceId":7}']
    end
    stubs.put("/fineract-provider/api/v1/users/7") { [200, { "Content-Type" => "application/json" }, "{}"] }
    client = client_with(stubs)
    result = client.users.create(firstname: "Jane", password: "secret", repeat_password: "secret")
    assert_equal 7, result.data["resourceId"]
    assert_equal 200, client.users.update(7, firstname: "Janet").status
    stubs.verify_stubbed_calls
  end

  def test_role_permission_assignment_is_transportable
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.put("/fineract-provider/api/v1/roles/3/permissions") do |env|
      assert_equal({ "permissions" => { "CREATE_CLIENT" => true } }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end
    assert_equal 200, client_with(stubs).roles.update_permissions(3, permissions: { "CREATE_CLIENT" => true }).status
    stubs.verify_stubbed_calls
  end

  def test_invalid_local_input_returns_failure_without_transport
    stubs = Faraday::Adapter::Test::Stubs.new
    result = client_with(stubs).users.retrieve("7")
    assert_instance_of Fineract::Failure, result
    assert_instance_of Fineract::ValidationError, result.failure
    stubs.verify_stubbed_calls
  end

  def test_passwords_and_api_errors_are_redacted
    error = Fineract::ApiError.new(status: 400, payload: { "password" => "secret", "errors" => [{ "token" => "abc" }] })
    assert_equal "[REDACTED]", error.payload["password"]
    assert_equal "[REDACTED]", error.parameter_errors.first["token"]
    refute_includes error.inspect, "secret"
  end
end

# rubocop:enable all
