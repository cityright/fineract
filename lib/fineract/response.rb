# frozen_string_literal: true

module Fineract
  Response = Data.define(:status, :headers, :data, :body) do
    def request_id
      headers["x-request-id"] || headers["x-correlation-id"]
    end

    def success?
      status.between?(200, 299)
    end
  end
end
