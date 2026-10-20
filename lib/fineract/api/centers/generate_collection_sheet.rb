# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::GenerateCollectionSheet
      #   Fineract::Api::Centers::GenerateCollectionSheet.generate(id: 1)
      #
      class GenerateCollectionSheet < AuthorisedBase
        post :generate, "/centers/:id?command=generateCollectionSheet", rubify_names: true
      end
    end
  end
end
