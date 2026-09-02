# frozen_string_literal: true

require "logger"
require "stringio"

# rubocop:disable Metrics/BlockLength
RSpec.describe Fineract::Transport do
  def client_with(stubs, **options)
    Fineract.client(**{
      adapter: [:test, stubs],
      retry_options: { max: 2, interval: 0, interval_randomness: 0, backoff_factor: 1 }
    }.merge(options))
  end

  it "supports every HTTP verb and applies shared headers" do
    stubs = Faraday::Adapter::Test::Stubs.new
    %i[get post put patch delete].each do |verb|
      stubs.public_send(verb, "/fineract-provider/api/v1/widgets") do |env|
        expect(env.request_headers["User-Agent"]).to eq("transport-test")
        expect(env.request_headers["Fineract-Platform-TenantId"]).to eq("tenant-a")
        [204, {}, ""]
      end
    end
    client = client_with(stubs, user_agent: "transport-test", tenant_id: "tenant-a")

    %i[get post put patch delete].each do |verb|
      expect(client.public_send(verb, "widgets").status).to eq(204)
    end
    stubs.verify_stubbed_calls
  end

  it "encodes path substitutions separately from query parameters" do
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/clients/a%2Fb%20c") do |env|
      expect(env.params).to eq("search" => "x/y z", "api_key" => "query-secret")
      [200, { "Content-Type" => "application/json" }, '{"ok":true}']
    end
    response = client_with(stubs).get(
      "clients/{client_id}", path_params: { client_id: "a/b c" },
                             query: { search: "x/y z", api_key: "query-secret" }
    )

    expect(response.data).to eq("ok" => true)
    stubs.verify_stubbed_calls
  end

  it "encodes JSON, form, text, CSV, binary, and multipart request bodies" do
    stubs = Faraday::Adapter::Test::Stubs.new
    expected = {
      json: ["application/json", '{"amount":10}'],
      form: ["application/x-www-form-urlencoded", "amount=10"],
      text: ["text/plain", "hello"], csv: ["text/csv", "a,b\n"],
      binary: ["application/octet-stream", "\x00\xFF".b]
    }
    expected.each do |type, (content_type, body)|
      stubs.post("/fineract-provider/api/v1/#{type}") do |env|
        expect(env.request_headers["Content-Type"]).to eq(content_type)
        expect(env.body).to eq(body)
        [204, {}, ""]
      end
    end
    stubs.post("/fineract-provider/api/v1/multipart") do |env|
      expect(env.request_headers["Content-Type"]).to start_with("multipart/form-data; boundary=")
      expect(env.body).to include('name="description"', "document", 'name="file"', "contents")
      [204, {}, ""]
    end
    client = client_with(stubs)

    client.post("json", body: { amount: 10 })
    client.post("form", body: { amount: 10 }, request_type: :form)
    client.post("text", body: "hello", request_type: :text)
    client.post("csv", body: "a,b\n", request_type: :csv)
    client.post("binary", body: "\x00\xFF".b, request_type: :binary)
    client.post("multipart", body: { description: "document", file: StringIO.new("contents") },
                             request_type: :multipart)
    stubs.verify_stubbed_calls
  end

  it "decodes JSON, text, CSV, binary, and empty responses" do
    stubs = Faraday::Adapter::Test::Stubs.new
    responses = {
      json: [200, { "Content-Type" => "application/json" }, '{"id":1}'],
      text: [200, { "Content-Type" => "text/plain" }, "hello"],
      csv: [200, { "Content-Type" => "text/csv" }, "a,b\n"],
      binary: [200, { "Content-Type" => "application/pdf" }, "\x00\xFF".b],
      empty: [204, {}, ""]
    }
    responses.each { |name, value| stubs.get("/fineract-provider/api/v1/#{name}") { value } }
    client = client_with(stubs)

    expect(client.get("json").data).to eq("id" => 1)
    expect(client.get("text").data).to eq("hello")
    expect(client.get("csv").data).to eq("a,b\n")
    expect(client.get("binary").data.encoding).to eq(Encoding::BINARY)
    expect(client.get("empty").data).to be_nil
    stubs.verify_stubbed_calls
  end

  it "honors connection settings, authentication, and the configured adapter" do
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/settings") do |env|
      expect(env.request_headers["Authorization"]).to eq("Basic dXNlcjpzZWNyZXQ=")
      [204, {}, ""]
    end
    transport = client_with(stubs, username: "user", password: "secret", timeout: 17,
                                   open_timeout: 8, verify_ssl: false).transport

    expect(transport.connection.options.timeout).to eq(17)
    expect(transport.connection.options.open_timeout).to eq(8)
    expect(transport.connection.ssl.verify).to be(false)
    transport.get("settings")
    stubs.verify_stubbed_calls
  end

  it "retries connection failures, 429, and transient 5xx for idempotent requests" do
    stubs = Faraday::Adapter::Test::Stubs.new
    attempts = 0
    stubs.get("/fineract-provider/api/v1/retry") do
      attempts += 1
      raise Faraday::ConnectionFailed, "offline"
    end
    stubs.get("/fineract-provider/api/v1/retry") do
      attempts += 1
      [429, {}, "busy"]
    end
    stubs.get("/fineract-provider/api/v1/retry") do
      attempts += 1
      [503, {}, "busy"]
    end
    stubs.get("/fineract-provider/api/v1/retry") do
      attempts += 1
      [200, { "Content-Type" => "text/plain" }, "ok"]
    end

    expect(client_with(stubs, retry_options: { max: 3, interval: 0 }).get("retry").data).to eq("ok")
    expect(attempts).to eq(4)
    stubs.verify_stubbed_calls
  end

  it "does not retry financial mutations unless explicitly made safe" do
    stubs = Faraday::Adapter::Test::Stubs.new
    unsafe_attempts = 0
    safe_attempts = 0
    stubs.post("/fineract-provider/api/v1/loans/1/transactions") do
      unsafe_attempts += 1
      [503, {}, "busy"]
    end
    stubs.post("/fineract-provider/api/v1/loans/2/transactions") do |env|
      safe_attempts += 1
      expect(env.request_headers["Idempotency-Key"]).to eq("payment-123")
      safe_attempts == 1 ? [503, {}, "busy"] : [200, { "Content-Type" => "application/json" }, "{}"]
    end
    client = client_with(stubs)

    expect(client.post("loans/1/transactions").status).to eq(503)
    expect(client.post("loans/2/transactions", idempotency_key: "payment-123").status).to eq(200)
    expect([unsafe_attempts, safe_attempts]).to eq([1, 2])
    stubs.verify_stubbed_calls
  end

  it "redacts credentials and secrets from logger output" do
    output = StringIO.new
    logger = Logger.new(output)
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("/fineract-provider/api/v1/private") { [204, {}, ""] }
    client_with(stubs, username: "user", password: "secret", logger: logger).get(
      "private", query: { access_token: "token-secret", api_key: "key-secret" },
                 headers: { "Cookie" => "session-secret", "X-Password" => "password-secret" }
    )

    expect(output.string).to include("[REDACTED]", "status=204")
    expect(output.string).not_to include("secret", "dXNlcjpzZWNyZXQ=", "token-secret", "key-secret")
  end
end
# rubocop:enable Metrics/BlockLength
