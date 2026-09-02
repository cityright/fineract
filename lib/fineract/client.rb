# frozen_string_literal: true

module Fineract
  # A client with an immutable, independently validated configuration.
  class Client
    attr_reader :configuration, :transport

    def initialize(**options)
      @configuration = Configuration.new(Fineract.config.to_h.merge(options))
      @transport = Transport.new(@configuration)
    end

    def request(...)
      transport.request(...)
    end

    %i[get post put patch delete].each do |verb|
      define_method(verb) { |path, **options| transport.public_send(verb, path, **options) }
    end
  end
end
