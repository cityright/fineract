# frozen_string_literal: true

require "json"

module Fineract
  class OperationCatalog
    HTTP_METHODS = %w[get post put patch delete].freeze
    SPECIFICATION = File.expand_path("../../specifications/fineract-1.15.0.json", __dir__)

    Operation = Data.define(
      :name, :method, :path, :parameters, :request_media_types, :response_media_types,
      :request_required, :request_schema
    ) do
      def path_parameters = parameters.select { |parameter| parameter["in"] == "path" }
      def query_parameters = parameters.select { |parameter| parameter["in"] == "query" }
      def header_parameters = parameters.select { |parameter| parameter["in"] == "header" }
    end

    def self.default = (@default ||= new)

    def initialize(document = JSON.parse(File.read(SPECIFICATION)))
      @operations = {}
      document.fetch("paths").each do |path, path_item|
        path_item_params = path_item.fetch("parameters", [])
        path_item.each do |method, definition|
          next unless HTTP_METHODS.include?(method)

          definition = dereference(definition, document)
          parameters = (path_item_params + definition.fetch("parameters", [])).map do |parameter|
            dereference(parameter, document)
          end
          name = definition.fetch("operationId")
          operation = Operation.new(
            name, method.to_sym, normalize_path(path), parameters,
            definition.dig("requestBody", "content")&.keys || [],
            response_media_types(definition.fetch("responses")),
            definition.dig("requestBody", "required") == true,
            dereference(definition.dig("requestBody", "content")&.values&.first&.fetch("schema", nil), document)
          )
          @operations[name] = operation
          @operations[underscore(name)] ||= operation
        end
      end
      @operations.freeze
    end

    def fetch(name) = @operations.fetch(name.to_s) { raise KeyError, name.to_s }
    def include?(name) = @operations.key?(name.to_s)
    def each(&block) = @operations.values.uniq(&:name).each(&block)
    def size = each.count

    private

    def response_media_types(responses)
      response = responses.find { |status, _| status.to_s.start_with?("2") }&.last || responses["default"] || {}
      response.fetch("content", {}).keys
    end

    def normalize_path(path)
      normalized = path.sub(%r{\A/v1(?=/|\z)}, "")
      normalized.empty? ? "/" : normalized
    end

    def underscore(name)
      name.to_s.gsub(/([A-Z]+)([A-Z][a-z])/, '\\1_\\2').gsub(/([a-z\d])([A-Z])/, '\\1_\\2').downcase
    end

    def dereference(value, document)
      return value unless value.is_a?(Hash) && value["$ref"]

      value["$ref"].split("/").drop(1).inject(document) { |current, key| current.fetch(key) }
    end
  end

  Catalog = OperationCatalog
  Endpoint = OperationCatalog::Operation
end
