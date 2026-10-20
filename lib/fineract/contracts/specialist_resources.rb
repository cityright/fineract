# frozen_string_literal: true

require "dry/validation"

module Fineract
  module Contracts
    module SpecialistResources
      class Document < Dry::Validation::Contract
        params { required(:file).filled }
      end
    end
  end
end
