# frozen_string_literal: true

module Fineract
  module Api
    module Groups
      # @example Groups::DeleteGroup
      #   Fineract::Api::Groups::DeleteGroup.remove(id)
      #
      class DeleteGroup < AuthorisedBase
        delete :remove, "/groups/:id", rubify_names: true
      end
    end
  end
end
