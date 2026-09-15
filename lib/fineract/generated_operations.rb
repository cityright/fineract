# frozen_string_literal: true

module Fineract
  # Generated endpoint facade providing a named resource method for every pinned
  # Fineract operation. Domain resources remain the preferred ergonomic API; this
  # facade gives complete, version-pinned coverage while a consumer needs an API
  # that does not yet have a richer domain wrapper.
  class GeneratedOperations < Resource
    OperationCatalog.default.each do |operation|
      define_method(operation.name) do |path: {}, query: {}, headers: {}, body: nil, request_type: nil, response_type: nil, idempotent: nil, idempotency_key: nil|
        client.call(operation.name, path: path, query: query, headers: headers, body: body,
                                    request_type: request_type, response_type: response_type,
                                    idempotent: idempotent, idempotency_key: idempotency_key)
      end
    end
  end
end
