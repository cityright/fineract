# frozen_string_literal: true

# Public Fineract namespace.
module Fineract
  # Authentication strategies for Fineract HTTP requests.
  module Authentication
    # Username/password HTTP Basic authentication.
    class Basic
      def initialize(username, password)
        validate!(username, :username)
        validate!(password, :password)
        @username = username
        @password = password
      end

      def apply(request)
        credentials = ["#{@username}:#{@password}"].pack("m0")
        request.headers["Authorization"] = "Basic #{credentials}"
      end

      private

      def validate!(value, name)
        return if value.is_a?(String) && !value.empty?

        raise ConfigurationError, "#{name} must be a non-empty String"
      end
    end

    # Pre-encoded HTTP Basic authentication key.
    class BasicKey
      def initialize(key)
        raise ConfigurationError, "basic_key must be a non-empty String" unless key.is_a?(String) && !key.empty?

        @key = key.sub(/\ABasic\s+/i, "")
      end

      def apply(request)
        request.headers["Authorization"] = "Basic #{@key}"
      end
    end

    # Bearer token authentication.
    class Bearer
      def initialize(token)
        raise ConfigurationError, "bearer_token must be a non-empty String" unless token.is_a?(String) && !token.empty?

        @token = token.sub(/\ABearer\s+/i, "")
      end

      def apply(request)
        request.headers["Authorization"] = "Bearer #{@token}"
      end
    end
  end

  Auth = Authentication unless const_defined?(:Auth, false)
end
