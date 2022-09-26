# frozen_string_literal: true

module Fineract
    module Api
      module Groups
        # @example Groups::ListGroups
        #   Fineract::Api::Groups::ListGroups.all()
        #
        class ListGroups < AuthorisedBase
          get :all, "/groups", rubify_names: true
        end
      end
    end
  end
  