# frozen_string_literal: true

require "dry-struct"
require "uri"

module Fineract
  # Shared strict dry-types used by public value objects.
  module Types
    include Dry.Types()
  end

  # Immutable, validated settings captured by each client.
  class Configuration < Dry::Struct
    transform_keys(&:to_sym)

    attribute :base_url, Types::Strict::String
    attribute :api_version, Types::Strict::String
    attribute :tenant_id, Types::Strict::String
    attribute :username, Types::Strict::String.optional
    attribute :password, Types::Strict::String.optional
    attribute :basic_key, Types::Strict::String.optional
    attribute :bearer_token, Types::Strict::String.optional
    attribute :authentication, Types::Any.optional
    attribute :timeout, Types::Strict::Integer | Types::Strict::Float
    attribute :open_timeout, Types::Strict::Integer | Types::Strict::Float
    attribute :logger, Types::Any.optional
    attribute :adapter, Types::Any
    attribute :retry_options, Types::Strict::Hash
    attribute :verify_ssl, Types::Strict::Bool
    attribute :user_agent, Types::Strict::String
    attribute :locale, Types::Strict::String.optional
    attribute :date_format, Types::Strict::String.optional

    def self.new(attributes)
      attributes = attributes.to_h.transform_keys(&:to_sym)
      attributes[:base_url] = normalize_base_url(attributes[:base_url])
      validate!(attributes)
      super(attributes.merge(retry_options: attributes[:retry_options].dup.freeze))
    rescue Dry::Struct::Error, TypeError => e
      raise ConfigurationError, e.message
    end

    def self.normalize_base_url(value)
      raise ConfigurationError, "base_url is required" if value.nil? || value.to_s.strip.empty?
      raise ConfigurationError, "base_url must be a String" unless value.is_a?(String)

      normalized = value.strip.sub(%r{/+\z}, "")
      uri = URI.parse(normalized)
      raise ConfigurationError, "base_url must be an HTTP(S) URL without embedded credentials" unless uri.is_a?(URI::HTTP) && uri.host && !uri.userinfo

      normalized
    rescue URI::InvalidURIError
      raise ConfigurationError, "base_url must be a valid HTTP(S) URL"
    end

    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity

    # rubocop:disable Metrics/AbcSize
    def self.validate!(attributes)
      validate_non_empty!(attributes, :api_version, :tenant_id, :user_agent)
      validate_positive_number!(attributes, :timeout, :open_timeout)

      raise ConfigurationError, "username and password must be provided together" if attributes[:username].nil? != attributes[:password].nil?

      configured = [attributes[:authentication], attributes[:basic_key], attributes[:bearer_token],
                    attributes[:username]].compact
      raise ConfigurationError, "only one authentication strategy may be configured" if configured.size > 1
      raise ConfigurationError, "authentication must respond to apply(request)" if attributes[:authentication] && !attributes[:authentication].respond_to?(:apply)

      validate_non_empty_optional!(attributes, :basic_key, :bearer_token)

      return if attributes[:retry_options].is_a?(Hash)

      raise ConfigurationError, "retry_options must be a Hash"
    end

    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
    def self.validate_non_empty!(attributes, *names)
      names.each do |name|
        value = attributes[name]
        raise ConfigurationError, "#{name} must be a non-empty String" unless value.is_a?(String) && !value.empty?
      end
    end

    def self.validate_positive_number!(attributes, *names)
      names.each do |name|
        value = attributes[name]
        raise ConfigurationError, "#{name} must be a positive number" unless value.is_a?(Numeric) && value.positive?
      end
    end

    def self.validate_non_empty_optional!(attributes, *names)
      names.each do |name|
        value = attributes[name]
        next if value.nil? || (value.is_a?(String) && !value.empty?)

        raise ConfigurationError, "#{name} must be a non-empty String"
      end
    end

    private_class_method :normalize_base_url, :validate!, :validate_non_empty!,
                         :validate_positive_number!, :validate_non_empty_optional!
  end
end
