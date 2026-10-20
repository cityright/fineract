# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListProductMixes
      #   Fineract::Api::Org::ListProductMixes.all()
      #
      class ListProductMixes < AuthorisedBase
        get :all, "/loanproducts?associations=productMixes", rubify_names: true
      end
    end
  end
end
