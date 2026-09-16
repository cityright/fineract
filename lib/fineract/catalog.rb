# frozen_string_literal: true

module Fineract
  # Immutable, pinned OpenAPI operation definitions. The source document is not
  # read at runtime; regenerate this catalog when upgrading the pinned spec.
  class OperationCatalog
    Operation = Data.define(
      :name, :method, :path, :tags, :parameters, :request_media_types,
      :request_schemas, :response_media_types, :security, :request_required,
      :deprecated
    ) do
      def path_parameters = parameters.select { |parameter| parameter["in"] == "path" }
      def query_parameters = parameters.select { |parameter| parameter["in"] == "query" }
      def header_parameters = parameters.select { |parameter| parameter["in"] == "header" }

      def request_schema(media_type = request_media_types.first) = request_schemas[media_type]
    end

    def self.default = (@default ||= new)

    def initialize(definitions = GeneratedEndpointDefinitions::RAW)
      entries = definitions.map { |definition| operation_from(definition) }
      @operations = entries.to_h { |operation| [operation.name, operation] }.freeze
      @aliases = entries.to_h { |operation| [underscore(operation.name), operation] }.freeze
      raise ArgumentError, "generated endpoint names are not unique" unless @operations.length == entries.length
    end

    def fetch(name) = @operations.fetch(name.to_s) { @aliases.fetch(name.to_s) { raise KeyError, name.to_s } }
    def include?(name) = @operations.key?(name.to_s) || @aliases.key?(name.to_s)
    def each(&block) = @operations.values.sort_by(&:name).each(&block)
    def size = @operations.size

    private

    def operation_from(definition)
      Operation.new(
        definition.fetch("operation"), definition.fetch("method").downcase.to_sym,
        definition.fetch("path"), definition.fetch("tags"), definition.fetch("parameters"),
        definition.fetch("request_media_types"), definition.fetch("request_schemas"),
        definition.fetch("response_media_types"), definition.fetch("security"),
        definition.fetch("request_required"), definition.fetch("deprecated")
      ).freeze
    end

    def underscore(name)
      name.gsub(/([A-Z]+)([A-Z][a-z])/, "\\1_\\2").gsub(/([a-z\d])([A-Z])/, "\\1_\\2").downcase
    end
  end

  Catalog = OperationCatalog
  Endpoint = OperationCatalog::Operation

  # Every generated definition is registered exactly once. The underscored
  # alias is only a lookup convenience and does not create another endpoint.
  class OperationRegistry
    Entry = Data.define(:name, :operation) do
      def method = operation.method
      def path = operation.path

      def signature
        {
          "operation" => name, "method" => method.to_s.upcase, "path" => path,
          "path_parameters" => operation.path_parameters.map { |p| p.fetch("name") }.sort,
          "query_parameters" => operation.query_parameters.map { |p| p.fetch("name") }.sort,
          "header_parameters" => operation.header_parameters.map { |p| p.fetch("name") }.sort,
          "request_media_types" => operation.request_media_types.sort,
          "response_media_types" => operation.response_media_types.sort,
          "deprecated" => operation.deprecated
        }
      end
    end

    def self.default = (@default ||= new)

    def initialize(catalog = OperationCatalog.default)
      @entries = {}
      @aliases = {}
      catalog.each { |operation| register(operation) }
      @entries.freeze
      @aliases.freeze
      freeze
    end

    def register(operation)
      name = operation.name.to_s
      raise ArgumentError, "operation already registered: #{name}" if @entries.key?(name)

      entry = Entry.new(name, operation).freeze
      @entries[name] = entry
      @aliases[underscore(name)] = entry
    end

    def fetch(name) = @entries.fetch(name.to_s) { @aliases.fetch(name.to_s) { raise KeyError, name.to_s } }
    def include?(name) = @entries.key?(name.to_s) || @aliases.key?(name.to_s)
    def each(&block) = @entries.values.sort_by(&:name).each(&block)
    def size = @entries.size

    private

    def underscore(name)
      name.gsub(/([A-Z]+)([A-Z][a-z])/, "\\1_\\2").gsub(/([a-z\d])([A-Z])/, "\\1_\\2").downcase
    end
  end
end
