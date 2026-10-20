# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::DeleteTeller
      #   Fineract::Api::Org::DeleteTeller.remove(id: 1)
      #
      class DeleteTeller < AuthorisedBase
        delete :remove, "/tellers/:id", rubify_names: true
      end
    end
  end
end
