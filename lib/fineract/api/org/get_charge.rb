# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetCharge
      #   Fineract::Api::Org::GetCharge.find(id: 1)
      #
      class GetCharge < AuthorisedBase
        get :find, "/charges/:id", rubify_names: true
      end
    end
  end
end
