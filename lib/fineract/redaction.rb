# frozen_string_literal: true

# rubocop:disable all

module Fineract
  module Redaction
    SENSITIVE = /authorization|cookie|token|password|api[-_]?key|secret/i
    def self.call(value)
      case value
      when Hash
        value.each_with_object({}) { |(key, item), result| result[key] = SENSITIVE.match?(key.to_s) ? "[REDACTED]" : call(item) }
      when Array then value.map { |item| call(item) }
      when String
        begin JSON.generate(call(JSON.parse(value))) rescue JSON::ParserError; value.gsub(/((?:password|token|secret|api[_-]?key)\s*[=:]\s*["']?)[^,\s"']+/i, '\\1[REDACTED]') end
      else value
      end
    end
  end
end

# rubocop:enable all
