# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::AssociateGroups
      #   Fineract::Api::Centers::AssociateGroups.associate(id: 1)
      #
      class AssociateGroups < AuthorisedBase
        post :associate, "/centers/:id?command=associateGroups", rubify_names: true
      end
    end
  end
end
