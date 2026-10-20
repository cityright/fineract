# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateTeller
      #   Fineract::Api::Org::UpdateTeller.save(id: 1)
      #
      class UpdateTeller < AuthorisedBase
        put :save, "/tellers/:id", rubify_names: true
      end
    end
  end
end
