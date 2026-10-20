# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateTemplate
      #   Fineract::Api::Org::CreateTemplate.create()
      #
      class CreateTemplate < AuthorisedBase
        post :create, "/templates", rubify_names: true
      end
    end
  end
end
