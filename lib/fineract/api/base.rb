# frozen_string_literal: true

module Fineract
  module Api
    # Rest client configuration
    # @abstract
    #
    class Base < Flexirest::Base
      # @NOTE: It's recommended that we configure the `base_url` via
      # the `Flexirest::Base.base_url` class method as setting it directly
      # results in side effects that pollute the `Flexirest::Base` superclass
      #
      base_url "#{ENV["FINERACT_BASE_URL"]}/fineract-provider/api/v1"

      request_body_type :json

      protected

      def camelize_params(_name, request)
        request.post_params.transform_keys! do |key|
          key.to_s.camelize.to_sym
        end
      end
    end
  end
end
