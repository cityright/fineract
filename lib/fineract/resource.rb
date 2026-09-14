# frozen_string_literal: true

# rubocop:disable all

module Fineract
  class Resource
    attr_reader :client
    def initialize(client) = @client = client

    private
    def call(operation, path: {}, query: {}, body: nil, request_type: nil)
      client.call(operation, path: path, query: query, body: body, request_type: request_type)
    end
    def id!(value, name)
      return value if value.is_a?(Integer) && value.positive?
      raise ValidationError, "#{name} must be a positive integer"
    end
    def wire_keys(attributes)
      attributes.to_h.each_with_object({}) do |(key, value), result|
        result[key.to_s.gsub(/_([a-z])/) { Regexp.last_match(1).upcase }] = value.is_a?(Hash) ? wire_keys(value) : value
      end
    end
    def safe_call
      yield
    rescue ValidationError => e
      Failure.new(e)
    end
  end
end

# rubocop:enable all
