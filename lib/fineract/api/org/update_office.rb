# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateOffice
      # params = { "id": 1, "name": "Some New Office"}
      #   Fineract::Api::Groups::UpdateOffices.save(params)
      #
      class UpdateOffice < AuthorisedBase
        put :save, "/offices/:id", rubify_names: true
      end
    end
  end
end
