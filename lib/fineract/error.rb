# frozen_string_literal: true

module Fineract
  class Error < StandardError; end
  class ConfigurationError < Error; end
end

module Fineract
  # Invalid local input.
  class ValidationError < Error
    attr_reader :details

    def initialize(message, details: nil)
      @details = details
      super(message)
    end
  end

  class UnknownOperationError < ValidationError; end

  # Network or HTTP transport failure.
  class TransportError < Error
    attr_reader :cause

    def initialize(message = nil, cause: nil)
      @cause = cause
      super(message || cause&.message)
    end
  end

  # Response serialization failure.
  class SerializationError < Error
    attr_reader :body, :cause

    def initialize(message = nil, body: nil, cause: nil)
      @body = Redaction.call(body)
      @cause = cause
      super(message || cause&.message)
    end
  end

  # Structured Fineract API failure.
  class ApiError < Error
    attr_reader :status, :payload, :globalisation_codes, :parameter_errors, :developer_message, :response

    def initialize(status:, payload:, response: nil)
      @status = status
      @payload = Redaction.call(payload)
      @response = response
      @globalisation_codes = if @payload.is_a?(Hash)
                               @payload.select do |k, _|
                                 k.to_s.downcase.include?("globalisationcode")
                               end.values
                             else
                               []
                             end
      @parameter_errors = @payload.is_a?(Hash) ? Array(@payload["errors"] || @payload[:errors]) : []
      @globalisation_codes += @parameter_errors.filter_map do |e|
        e["userMessageGlobalisationCode"] || e[:userMessageGlobalisationCode] if e.is_a?(Hash)
      end
      @globalisation_codes = @globalisation_codes.compact.uniq
      @developer_message = @payload.is_a?(Hash) ? (@payload["developerMessage"] || @payload[:developerMessage]) : nil
      super(@developer_message || "Fineract API request failed with status #{status}")
      # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    end
  end
end
