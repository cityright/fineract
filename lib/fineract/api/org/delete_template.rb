# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::DeleteTemplate
      #   Fineract::Api::Org::DeleteTemplate.remove(id: 1)
      #
      class DeleteTemplate < AuthorisedBase
        delete :remove, "/templates/:id", rubify_names: true
      end
    end
  end
end
