# frozen_string_literal: true

require "dry/validation"

module Fineract
  module Contracts
    module EntityMetadata
      class EntityDatatableCheckCreate < Dry::Validation::Contract
        params do
          required(:entity).filled(:string)
          required(:status).filled(:integer)
          required(:datatable_name).filled(:string)
          optional(:product_id).maybe(:integer)
        end
      end
    end
  end
end
