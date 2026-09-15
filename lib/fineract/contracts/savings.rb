# frozen_string_literal: true

module Fineract
  module Contracts
    module Savings
      module_function

      def product_create(attributes)
        require_string!(attributes, :name)
        require_string!(attributes, :short_name)
      end

      def account_create(attributes)
        require_positive_integer!(attributes, :client_id)
        require_positive_integer!(attributes, :product_id)
      end

      def transaction_create(attributes)
        amount = attributes[:amount] || attributes[:transaction_amount]
        raise ValidationError, "amount must be a positive number" if amount && (!amount.is_a?(Numeric) || amount <= 0)
      end

      def require_string!(attributes, name)
        value = attributes.fetch(name) { raise ValidationError, "#{name} is required" }
        raise ValidationError, "#{name} must be a non-empty string" unless value.is_a?(String) && !value.empty?
      end

      def require_positive_integer!(attributes, name)
        value = attributes.fetch(name) { raise ValidationError, "#{name} is required" }
        raise ValidationError, "#{name} must be a positive integer" unless value.is_a?(Integer) && value.positive?
      end
    end
  end
end
