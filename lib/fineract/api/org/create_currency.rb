# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateCurrency
      #   Fineract::Api::Org::CreateCurrency.create()
      #
      class CreateCurrency < AuthorisedBase
        post :create, "/currencies", rubify_names: true
      end
    end
  end
end
