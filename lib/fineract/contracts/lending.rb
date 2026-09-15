# frozen_string_literal: true

# rubocop:disable all

require "dry/validation"

module Fineract
  module Contracts
    module Lending
      class Collateral < Dry::Validation::Contract
        params { optional(:type).maybe(:string); optional(:value).maybe(:numeric) }
      end
      class Guarantor < Dry::Validation::Contract
        params { optional(:client_id).maybe(:integer); optional(:guarantor_type).maybe(:string) }
      end
      class WorkingCapitalLoan < Dry::Validation::Contract
        params { optional(:client_id).maybe(:integer); optional(:product_id).maybe(:integer); optional(:principal).maybe(:numeric) }
      end
      class ExternalAssetOwner < Dry::Validation::Contract
        params { optional(:name).maybe(:string); optional(:external_id).maybe(:string) }
      end
    end
  end
end
# rubocop:enable all
