# frozen_string_literal: true

# rubocop:disable all

module Fineract
  class Resource
    attr_reader :client
    def initialize(client) = @client = client

    private
    def call(operation, path: {}, query: {}, body: nil, request_type: nil, response_type: nil, idempotent: nil)
      client.call(operation, path: path, query: query, body: body, request_type: request_type, response_type: response_type, idempotent: idempotent)
    end
    def id!(value, name)
      return value if value.is_a?(Integer) && value.positive?
      raise ValidationError, "#{name} must be a positive integer"
    end
    def wire_keys(attributes)
      attributes.to_h.each_with_object({}) do |(key, value), result|
        result[key.to_s.gsub(/_([a-z])/) { Regexp.last_match(1).upcase }] = value.is_a?(Hash) ? wire_keys(value) : value.is_a?(Array) ? value.map { |item| item.is_a?(Hash) ? wire_keys(item) : item } : value
      end
    end
    def mapped_keys(attributes, mapping = {})
      attributes.to_h.each_with_object({}) do |(key, value), result|
        wire_key = mapping.fetch(key.to_sym) { key.to_s.gsub(/_([a-z])/) { Regexp.last_match(1).upcase } }
        result[wire_key] = value.is_a?(Hash) ? mapped_keys(value) : value.is_a?(Array) ? value.map { |item| item.is_a?(Hash) ? mapped_keys(item) : item } : value
      end
    end
    def safe_call
      yield
    rescue ValidationError => e
      Failure.new(e)
    end
    def validate_contract(contract, attributes, method = nil)
      result = method ? contract.public_send(method, attributes) : contract.new.call(attributes)
      return result unless result.respond_to?(:success?)
      raise ValidationError, result.errors.to_h.inspect unless result.success?
    end
  end
end

# rubocop:enable all
