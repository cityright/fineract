# frozen_string_literal: true

require "uri"
# The transport intentionally centralizes the complete HTTP wire policy.
# rubocop:disable Metrics, Style/MultilineBlockChain

module Fineract
  # Shared Faraday transport for every resource client.
  class Transport
    METHODS = %i[get post put patch delete].freeze
    IDEMPOTENT_METHODS = %i[get put delete].freeze
    RETRY_STATUSES = [429, 500, 502, 503, 504].freeze
    SENSITIVE_NAME = /authorization|cookie|token|password|api[-_]?key|secret/i

    attr_reader :configuration, :connection

    def initialize(configuration)
      @configuration = configuration
      @connection = build_connection
    end

    def request(method, path, path_params: {}, query: {}, body: nil, headers: {},
                request_type: :json, response_type: nil, idempotent: nil, idempotency_key: nil)
      method = method.to_sym
      raise ArgumentError, "unsupported HTTP method: #{method}" unless METHODS.include?(method)

      request_path = interpolate_path(path, path_params)
      request_headers = default_headers.merge(stringify_headers(headers))
      request_headers["Idempotency-Key"] = idempotency_key if idempotency_key
      encoded_body = encode_body(body, request_type, request_headers)
      safe = idempotent.nil? ? IDEMPOTENT_METHODS.include?(method) : idempotent
      safe ||= !idempotency_key.nil?

      raw = with_retries(safe) do
        log_request(method, request_path, query, request_headers)
        connection.run_request(method, request_path, encoded_body, request_headers) do |request|
          request.params.update(query) unless query.nil? || query.empty?
        end.tap { |result| log_response(result) }
      end
      build_response(raw, response_type)
    end

    METHODS.each do |verb|
      define_method(verb) { |path, **options| request(verb, path, **options) }
    end

    private

    def build_connection
      Faraday.new(url: "#{configuration.base_url}/#{configuration.api_version.sub(%r{\A/+}, "")}",
                  ssl: { verify: configuration.verify_ssl }) do |faraday|
        faraday.options.timeout = configuration.timeout
        faraday.options.open_timeout = configuration.open_timeout
        adapter = configuration.adapter
        adapter.is_a?(Array) ? faraday.adapter(*adapter) : faraday.adapter(adapter)
      end
    end

    def interpolate_path(path, values)
      result = path.to_s.dup
      values.each do |name, value|
        encoded = URI.encode_www_form_component(value.to_s).gsub("+", "%20")
        result.gsub!("{#{name}}", encoded)
        result.gsub!(":#{name}", encoded)
      end
      missing = result.scan(/\{([^}]+)\}/).flatten
      raise ArgumentError, "missing path parameter: #{missing.first}" unless missing.empty?

      result.sub(%r{\A/+}, "")
    end

    def default_headers
      headers = { "Accept" => "application/json", "User-Agent" => configuration.user_agent,
                  "Fineract-Platform-TenantId" => configuration.tenant_id }
      if configuration.username
        credentials = ["#{configuration.username}:#{configuration.password}"].pack("m0")
        headers["Authorization"] = "Basic #{credentials}"
      end
      configuration.authentication&.apply(Struct.new(:headers).new(headers))
      headers
    end

    def stringify_headers(headers)
      headers.to_h.transform_keys(&:to_s)
    end

    def encode_body(body, type, headers)
      return nil if body.nil?

      case type.to_sym
      when :json
        headers["Content-Type"] ||= "application/json"
        JSON.generate(body)
      when :form
        headers["Content-Type"] ||= "application/x-www-form-urlencoded"
        Faraday::Utils.build_nested_query(body)
      when :multipart then encode_multipart(body, headers)
      when :binary
        headers["Content-Type"] ||= "application/octet-stream"
        body.respond_to?(:read) ? body.read : body.to_s
      when :text, :csv
        headers["Content-Type"] ||= type.to_sym == :csv ? "text/csv" : "text/plain"
        body.to_s
      else raise ArgumentError, "unsupported request type: #{type}"
      end
    end

    def encode_multipart(parts, headers)
      boundary = "fineract-#{format("%024x", rand(2**96))}"
      headers["Content-Type"] ||= "multipart/form-data; boundary=#{boundary}"
      chunks = parts.flat_map { |name, value| multipart_part(boundary, name, value) }
      (chunks << "--#{boundary}--\r\n").join.b
    end

    def multipart_part(boundary, name, value)
      io = value.respond_to?(:read) ? value : nil
      content = io ? io.read : value.to_s
      filename = if io.respond_to?(:original_filename)
                   io.original_filename
                 elsif io.respond_to?(:path)
                   File.basename(io.path.to_s)
                 end
      disposition = %(form-data; name="#{name}")
      disposition += %(; filename="#{filename}") if filename && !filename.empty?
      lines = ["--#{boundary}", "Content-Disposition: #{disposition}"]
      lines << "Content-Type: #{io.respond_to?(:content_type) ? io.content_type : "application/octet-stream"}" if io
      ["#{lines.join("\r\n")}\r\n\r\n", content, "\r\n"]
    end

    def with_retries(safe)
      attempts = 0
      max = Integer(configuration.retry_options.fetch(:max, 0))
      begin
        raw = yield
        raise RetryableResponse, raw.status if safe && RETRY_STATUSES.include?(raw.status)

        raw
      rescue Faraday::ConnectionFailed, Faraday::TimeoutError, RetryableResponse
        raise unless safe && attempts < max

        sleep retry_interval(attempts)
        attempts += 1
        retry
      end
    end

    def retry_interval(attempt)
      options = configuration.retry_options
      interval = options.fetch(:interval, 0).to_f
      interval * options.fetch(:backoff_factor, 1).to_f**attempt *
        (1 + rand * options.fetch(:interval_randomness, 0).to_f)
    end

    def build_response(raw, explicit_type)
      body = raw.body
      type = explicit_type&.to_sym || inferred_response_type(raw.headers["content-type"], body)
      data = case type
             when :empty then nil
             when :json then JSON.parse(body.to_s)
             when :binary then body.to_s.b
             when :text, :csv then body.to_s
             else raise ArgumentError, "unsupported response type: #{type}"
             end
      Response.new(status: raw.status, headers: raw.headers, data: data, body: body)
    end

    def inferred_response_type(content_type, body)
      return :empty if body.nil? || body == ""
      return :json if content_type.to_s.match?(%r{(?:application|text)/[^;]*json})
      return :csv if content_type.to_s.match?(%r{(?:text/csv|application/csv)})
      return :text if content_type.to_s.start_with?("text/")

      :binary
    end

    def log_request(method, path, query, headers)
      return unless configuration.logger

      uri = connection.build_url(path, redact(query.to_h))
      configuration.logger.info("Fineract request #{method.to_s.upcase} #{uri} headers=#{redact(headers).inspect}")
    end

    def redact(values)
      values.each_with_object({}) do |(key, value), result|
        result[key] = SENSITIVE_NAME.match?(key.to_s) ? "[REDACTED]" : value
      end
    end

    def log_response(raw)
      configuration.logger&.info("Fineract response status=#{raw.status}")
    end

    class RetryableResponse < StandardError; end
  end
end
# rubocop:enable Metrics, Style/MultilineBlockChain
