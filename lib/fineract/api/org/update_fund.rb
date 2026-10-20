# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::UpdateFund
      #   Fineract::Api::Org::UpdateFund.save(id: 1)
      #
      class UpdateFund < AuthorisedBase
        put :save, "/funds/:id", rubify_names: true
      end
    end
  end
end
