# frozen_string_literal: true

require "uri"

# Spec Helpers
#
module Helpers
  def fineract_api_url(path = nil, params = {})
    URI::HTTPS.build(
      host: ENV["FINERACT_API_HOSTNAME"],
      port: ENV["FINERACT_API_PORT"],
      path: "/#{path}",
      query: params.to_query
    ).to_s
  end

  def stub_fineract_request(method, path, params = {})
    WebMock.stub_request(method, fineract_api_url(path, params))
  end

  def basic_headers_with_access_token(access_token, key = "Bearer")
    basic_headers.merge("Authorization" => "#{key} #{access_token}")
  end

  def basic_headers_with_login(credentials)
    access_token = Base64.strict_encode64("#{credentials[:public_key]}:#{credentials[:private_key]}")
    basic_headers_with_access_token(access_token, "Basic")
  end

  def with_modified_env(options, &block)
    ClimateControl.modify(options, &block)
  end

  def basic_headers
    {
      "Accept" => "application/hal+json, application/json;q=0.5",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Connection" => "Keep-Alive",
      "Content-Type" => "application/json; charset=utf-8",
      "User-Agent" => "Flexirest/#{Flexirest::VERSION}"
    }
  end
end
