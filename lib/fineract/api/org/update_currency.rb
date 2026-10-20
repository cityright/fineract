# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateCurrency
      #   Fineract::Api::Org::UpdateCurrency.save(id: 1)
      #
      class UpdateCurrency < AuthorisedBase
        put :save, "/currencies/:id", rubify_names: true
      end
    end
  end
end
