# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateStaff
      #   Fineract::Api::Org::CreateStaff.create()
      #
      class CreateStaff < AuthorisedBase
        post :create, "/staff", rubify_names: true
      end
    end
  end
end
