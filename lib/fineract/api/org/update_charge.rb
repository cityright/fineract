# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateCharge
      #   Fineract::Api::Org::UpdateCharge.save(id: 1)
      #
      class UpdateCharge < AuthorisedBase
        put :save, "/charges/:id", rubify_names: true
      end
    end
  end
end
