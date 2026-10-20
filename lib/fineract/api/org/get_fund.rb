# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetFund
      #   Fineract::Api::Org::GetFund.find(id: 1)
      #
      class GetFund < AuthorisedBase
        get :find, "/funds/:id", rubify_names: true
      end
    end
  end
end
