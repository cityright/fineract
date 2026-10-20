# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::DeleteCurrency
      #   Fineract::Api::Org::DeleteCurrency.remove(id: 1)
      #
      class DeleteCurrency < AuthorisedBase
        delete :remove, "/currencies/:id", rubify_names: true
      end
    end
  end
end
