# frozen_string_literal: true

module Fineract
  module Api
    module Groups
      # @example Groups::RetrieveGroup
      #   Fineract::Api::Groups::RetrieveGroup.find(id)
      #
      #
      class RetrieveGroup < AuthorisedBase
        get :find, "/groups/:id", rubify_names: true
      end
    end
  end
end
