# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetTeller
      #   Fineract::Api::Org::GetTeller.find(id: 1)
      #
      class GetTeller < AuthorisedBase
        get :find, "/tellers/:id", rubify_names: true
      end
    end
  end
end
