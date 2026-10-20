# frozen_string_literal: true

module Fineract
  module Contracts
    module Organization
      module_function

      # Staff requires identity and an existing positive office identifier.
      def staff_create(attributes)
        require_string!(attributes, :firstname)
        require_string!(attributes, :lastname)
        require_positive_integer!(attributes.fetch(:office_id), "office_id")
        attributes
      end

      def require_string!(attributes, name)
        value = attributes.fetch(name) { raise ValidationError, "#{name} is required" }
        raise ValidationError, "#{name} must be a non-empty string" unless value.is_a?(String) && !value.empty?
      end

      def require_positive_integer!(value, name)
        return value if value.is_a?(Integer) && value.positive?

        raise ValidationError, "#{name} must be a positive integer"
      end
    end
  end
end
# rubocop:enable all
