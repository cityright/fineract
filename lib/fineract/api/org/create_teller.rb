# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateTeller
      #   Fineract::Api::Org::CreateTeller.create()
      #
      class CreateTeller < AuthorisedBase
        post :create, "/tellers", rubify_names: true
      end
    end
  end
end
