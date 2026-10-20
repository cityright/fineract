# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::DisassociateGroups
      #   Fineract::Api::Centers::DisassociateGroups.disassociate(id: 1)
      #
      class DisassociateGroups < AuthorisedBase
        post :disassociate, "/centers/:id?command=disassociateGroups", rubify_names: true
      end
    end
  end
end
