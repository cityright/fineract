# frozen_string_literal: true

require "dry/validation"

module Fineract
  module Contracts
    module CashManagement
      class TellerCreate < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:office_id).filled(:integer)
          required(:start_date).filled(:string)
        end
        rule(:office_id) { key.failure("must be a positive integer") unless value.positive? }
      end

      class CashierCreate < Dry::Validation::Contract
        params do
          required(:staff_id).filled(:integer)
          required(:start_date).filled(:string)
        end
        rule(:staff_id) { key.failure("must be a positive integer") unless value.positive? }
      end

      class CashTransaction < Dry::Validation::Contract
        params do
          required(:txn_amount).filled
          required(:txn_date).filled(:string)
        end
        rule(:txn_amount) { key.failure("must be a positive amount") unless value.is_a?(Numeric) && value.positive? }
      end
    end
  end
end
