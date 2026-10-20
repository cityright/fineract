# frozen_string_literal: true

require "json"
require "test_helper"

class PlatformAdministrationTest < Minitest::Test
  def client_with(stubs, **options)
    Fineract.client(adapter: [:test, stubs], **options)
  end

  def test_configuration_and_cache_requests_are_mapped
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/configurations") do |env|
      assert_equal "true", env.params["survey"]
      [200, { "Content-Type" => "application/json" }, '{"configurations":[]}']
    end
    stubs.put("/fineract-provider/api/v1/caches") do |env|
      assert_equal({ "cacheType" => "SINGLE_NODE" }, JSON.parse(env.body))
      [200, { "Content-Type" => "application/json" }, "{}"]
    end

    client = client_with(stubs)
    assert_equal 200, client.administration.global_configuration.list(survey: true).status
    assert_equal 200, client.administration.cache.switch(cache_type: "SINGLE_NODE").status
    stubs.verify_stubbed_calls
  end

  def test_invalid_identifier_returns_failure_without_transport
    stubs = Faraday::Adapter::Test::Stubs.new
    result = client_with(stubs).administration.hooks.retrieve(0)

    assert_instance_of Fineract::Failure, result
    assert_instance_of Fineract::ValidationError, result.failure
    stubs.verify_stubbed_calls
  end

  def test_api_errors_are_returned_as_failures
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/audits/8") do
      [422, { "Content-Type" => "application/json" }, '{"developerMessage":"invalid audit"}']
    end

    result = client_with(stubs).administration.audits.retrieve(8)
    assert_instance_of Fineract::Failure, result
    assert_instance_of Fineract::ApiError, result.failure
    assert_equal 422, result.failure.status
    stubs.verify_stubbed_calls
  end

  def test_command_endpoint_does_not_retry
    stubs = Faraday::Adapter::Test::Stubs.new
    requests = 0
    stubs.post("/fineract-provider/api/v1/scheduler") do
      requests += 1
      [503, { "Content-Type" => "application/json" }, "{}"]
    end

    result = client_with(stubs, retry_options: { max: 2 }).administration.scheduler.command(command: "start")
    assert_instance_of Fineract::Failure, result
    assert_equal 1, requests
    stubs.verify_stubbed_calls
  end
end
