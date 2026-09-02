# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

RSpec.describe Fineract::Configuration do
  it "normalizes and validates global configuration immediately" do
    Fineract.configure do |config|
      config.base_url = " https://example.test/api/// "
      config.timeout = 3
    end

    expect(Fineract.client.configuration.base_url).to eq("https://example.test/api")
    expect(Fineract.client.configuration.timeout).to eq(3)
  end

  it "restores previous global settings after invalid configuration" do
    expect do
      Fineract.configure { |config| config.verify_ssl = nil }
    end.to raise_error(Fineract::ConfigurationError)

    expect(Fineract.config.verify_ssl).to be(true)
  end

  it "provides documented defaults" do
    configuration = Fineract.client.configuration

    expect(configuration.api_version).to eq("v1")
    expect(configuration.tenant_id).to eq("default")
    expect(configuration.timeout).to eq(10)
    expect(configuration.open_timeout).to eq(5)
    expect(configuration.verify_ssl).to be(true)
    expect(configuration.adapter).to eq(Faraday.default_adapter)
    expect(configuration.retry_options).to eq(Fineract::DEFAULT_RETRY_OPTIONS)
    expect(configuration.user_agent).to eq("fineract-ruby/#{Fineract::VERSION}")
    expect(configuration.locale).to be_nil
    expect(configuration.date_format).to be_nil
  end

  it "creates clients isolated from global and other client configuration" do
    first = Fineract.client(base_url: "https://one.example.test", tenant_id: "one")
    second = Fineract::Client.new(base_url: "https://two.example.test", tenant_id: "two")

    Fineract.configure { |config| config.tenant_id = "changed" }

    expect(first.configuration.tenant_id).to eq("one")
    expect(second.configuration.tenant_id).to eq("two")
    expect(Fineract.client.configuration.tenant_id).to eq("changed")
  end

  it "requires a base URL" do
    expect { Fineract.client(base_url: nil) }
      .to raise_error(Fineract::ConfigurationError, "base_url is required")
  end

  it "requires an HTTP(S) base URL without embedded credentials" do
    expect { Fineract.client(base_url: "ftp://example.test") }
      .to raise_error(Fineract::ConfigurationError, /HTTP\(S\)/)
    expect { Fineract.client(base_url: "https://user:secret@example.test") }
      .to raise_error(Fineract::ConfigurationError, /embedded credentials/)
  end

  it "requires positive timeouts" do
    expect { Fineract.client(timeout: 0) }
      .to raise_error(Fineract::ConfigurationError, /timeout must be a positive number/)
  end

  it "requires username and password together" do
    expect { Fineract.client(username: "jane") }
      .to raise_error(Fineract::ConfigurationError, /provided together/)
  end

  it "copies retry options into each client" do
    options = { max: 4 }
    client = Fineract.client(retry_options: options)
    options[:max] = 9
    expect(client.configuration.retry_options).to eq(max: 4)
    expect(client.configuration.retry_options).to be_frozen
  end
end
# rubocop:enable Metrics/BlockLength
