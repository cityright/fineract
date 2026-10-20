# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetStaff
      #   Fineract::Api::Org::GetStaff.find(id: 1)
      #
      class GetStaff < AuthorisedBase
        get :find, "/staff/:id", rubify_names: true
      end
    end
  end
end
