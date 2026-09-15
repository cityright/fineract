# frozen_string_literal: true
require "test_helper"
class GroupsCentersTest < Minitest::Test
  def test_membership_command_maps_clients_and_is_not_retried
    stubs = Faraday::Adapter::Test::Stubs.new
    attempts = 0
    stubs.post("/fineract-provider/api/v1/groups/4") do |env|
      attempts += 1
      assert_equal "associateClients", env.params["command"]
      assert_equal({ "clients" => [{ "id" => 7 }] }, JSON.parse(env.body))
      [503, {}, "busy"]
    end
    result = Fineract.client(adapter: [:test, stubs], retry_options: { max: 2 }).groups.associate_clients(4, clients: [7])
    assert_equal 503, result.status
    assert_equal 1, attempts
    stubs.verify_stubbed_calls
  end
  def test_invalid_membership_does_not_make_a_request
    client = Fineract.client
    client.define_singleton_method(:call) { raise "network request made" }
    result = client.groups.associate_clients(4, clients: [])
    assert result.failure?
    assert_instance_of Fineract::ValidationError, result.failure
  end
end
