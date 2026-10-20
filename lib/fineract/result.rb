# frozen_string_literal: true

require "dry/monads"

module Fineract
  # Result types returned by public operations.
  module Result
    # Successful operation result.
    class Success < Dry::Monads::Result::Success
      def method_missing(name, *args, &block)
        return super unless value!.respond_to?(name)

        value!.public_send(name, *args, &block)
      end

      def respond_to_missing?(name, include_private = false)
        value!.respond_to?(name, include_private) || super
      end
    end

    # Failed operation result.
    class Failure < Dry::Monads::Result::Failure
      def method_missing(name, *args, &block)
        return super unless failure.respond_to?(name)

        failure.public_send(name, *args, &block)
      end

      def respond_to_missing?(name, include_private = false)
        failure.respond_to?(name, include_private) || super
      end
    end
  end

  Success = Result::Success
  Failure = Result::Failure
end
