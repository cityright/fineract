# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetTemplate
      #   Fineract::Api::Org::GetTemplate.find(id: 1)
      #
      class GetTemplate < AuthorisedBase
        get :find, "/templates/:id", rubify_names: true
      end
    end
  end
end
