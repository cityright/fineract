# frozen_string_literal: true

module Fineract
  # A client with an immutable, independently validated configuration.
  class Client
    attr_reader :configuration

    def initialize(**options)
      @configuration = Configuration.new(Fineract.config.to_h.merge(options))
    end
  end
end
