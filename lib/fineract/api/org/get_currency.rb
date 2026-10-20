# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetCurrency
      #   Fineract::Api::Org::GetCurrency.find(id: 1)
      #
      class GetCurrency < AuthorisedBase
        get :find, "/currencies/:id", rubify_names: true
      end
    end
  end
end
