# frozen_string_literal: true

module Fineract
  module Api
    module Groups
      # @example Groups::UpdateGroup
      # params = { "id": 1, "name": "Some New Name"}
      #   Fineract::Api::Groups::UpdateGroup.save(params)
      #
      class UpdateGroup < AuthorisedBase
        put :save, "/groups/:id", rubify_names: true
      end
    end
  end
end
