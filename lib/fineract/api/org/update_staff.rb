# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateStaff
      #   Fineract::Api::Org::UpdateStaff.save(id: 1)
      #
      class UpdateStaff < AuthorisedBase
        put :save, "/staff/:id", rubify_names: true
      end
    end
  end
end
