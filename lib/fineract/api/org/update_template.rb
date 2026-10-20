# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateTemplate
      #   Fineract::Api::Org::UpdateTemplate.save(id: 1)
      #
      class UpdateTemplate < AuthorisedBase
        put :save, "/templates/:id", rubify_names: true
      end
    end
  end
end
