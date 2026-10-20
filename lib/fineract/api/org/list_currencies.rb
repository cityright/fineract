# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListCurrencies
      #   Fineract::Api::Org::ListCurrencies.all()
      #
      class ListCurrencies < AuthorisedBase
        get :all, "/currencies", rubify_names: true
      end
    end
  end
end
