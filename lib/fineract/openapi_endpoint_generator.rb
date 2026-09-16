# frozen_string_literal: true

require "json"
require "yaml"

module Fineract
  # Builds the checked-in endpoint definitions without modifying resource classes.
  class OpenapiEndpointGenerator
    HTTP_METHODS = %w[get post put patch delete].freeze
    RUBY_METHOD = /\A[a-zA-Z_]\w*[!?]?\z/

    def initialize(document:, overrides: {})
      @document = document
      @overrides = overrides.fetch("operations", overrides)
      @used_overrides = []
    end

    attr_reader :used_overrides

    def operations
      operations = @document.fetch("paths").flat_map do |path, path_item|
        path_item = dereference(path_item)
        path_parameters = Array(path_item["parameters"])
        path_item.filter_map do |method, definition|
          next unless HTTP_METHODS.include?(method)

          endpoint(method, path, path_parameters, dereference(definition))
        end
      end
      validate_names!(operations)
      validate_overrides!
      operations.sort_by { |operation| [operation.fetch("path"), operation.fetch("method")] }
    end

    def self.load_overrides(path)
      YAML.safe_load(File.read(path), permitted_classes: [], aliases: false) || {}
    end

    private

    def endpoint(method, path, path_parameters, definition)
      key = "#{method.upcase} #{path}"
      override = @overrides.fetch(key, {})
      @used_overrides << key if @overrides.key?(key)
      request_body = dereference(definition["requestBody"] || {})
      request_content = request_body["content"] || {}
      response_content = definition.fetch("responses", {}).values.flat_map { |response| dereference(response).fetch("content", {}).keys }
      {
        "operation" => override["operation_id"] || definition["operationId"],
        "method" => method.upcase,
        "path" => normalize_path(path),
        "tags" => Array(definition["tags"]).sort,
        "parameters" => (path_parameters + Array(definition["parameters"])).map { |parameter| parameter_definition(dereference(parameter)) },
        "request_media_types" => request_content.keys.sort,
        "request_schemas" => request_content.keys.sort.to_h { |type| [type, schema_shape(request_content.fetch(type)["schema"])] },
        "request_required" => request_body["required"] == true,
        "response_media_types" => response_content.uniq.sort,
        "security" => definition.key?("security") ? Array(definition["security"]) : Array(@document["security"]),
        "deprecated" => definition["deprecated"] == true
      }
    end

    def validate_names!(operations)
      operations.each do |operation|
        name = operation.fetch("operation")
        key = "#{operation.fetch("method")} #{operation.fetch("path")}"
        raise ArgumentError, "missing operationId for #{key}; add an operation_id override" if name.nil? || name.empty?
        raise ArgumentError, "unsuitable operationId #{name.inspect} for #{key}; add an operation_id override" unless RUBY_METHOD.match?(name)
      end
      duplicates = operations.group_by { |operation| operation.fetch("operation") }.select { |_name, values| values.length > 1 }
      return if duplicates.empty?

      raise ArgumentError, "duplicate operationId(s): #{duplicates.keys.sort.join(", ")}; add operation_id overrides"
    end

    def validate_overrides!
      stale = @overrides.keys - @used_overrides
      return if stale.empty?

      raise ArgumentError, "operation_id overrides do not match an OpenAPI operation: #{stale.sort.join(", ")}"
    end

    def normalize_path(path)
      normalized = path.sub(%r{\A/v1(?=/|\z)}, "")
      normalized.empty? ? "/" : normalized
    end

    # Preserve only the part of a schema needed by runtime validation, rather
    # than expanding the complete components tree into the generated file.
    def schema_shape(schema, seen = [])
      schema ||= {}
      if schema["$ref"]
        reference = schema.fetch("$ref")
        return {} if seen.include?(reference)

        target = reference.split("/").drop(1).reduce(@document) { |current, key| current.fetch(key) }
        return schema_shape(target, seen + [reference])
      end
      return nil if schema.empty?

      shape = schema.slice("type", "format", "enum", "required")
      shape["type"] ||= "object" if schema.key?("properties")
      shape["properties"] = schema.fetch("properties").transform_values { |value| schema_shape(value, seen) } if schema["properties"]
      shape["items"] = schema_shape(schema["items"], seen) if schema["items"]
      shape
    end

    def parameter_definition(parameter)
      parameter.slice("name", "in", "required", "description").tap do |result|
        result["schema"] = schema_shape(parameter["schema"]) if parameter["schema"]
        # OpenAPI permits a parameter to carry media-specific content instead
        # of schema. Keep the first deterministic media schema for validation.
        content = parameter["content"] || {}
        unless content.empty?
          type = content.keys.min
          result["schema"] ||= schema_shape(content.fetch(type)["schema"])
        end
      end
    end

    def dereference(value, seen = [])
      return value unless value.is_a?(Hash)

      if value["$ref"]
        reference = value.fetch("$ref")
        return value if seen.include?(reference)

        target = reference.split("/").drop(1).reduce(@document) { |current, key| current.fetch(key) }
        return dereference(target, seen + [reference])
      end
      value
    end
  end
end
