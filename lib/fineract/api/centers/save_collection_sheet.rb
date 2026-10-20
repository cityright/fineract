# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::SaveCollectionSheet
      #   Fineract::Api::Centers::SaveCollectionSheet.save(id: 1)
      #
      class SaveCollectionSheet < AuthorisedBase
        post :save, "/centers/:id?command=saveCollectionSheet", rubify_names: true
      end
    end
  end
end
