# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateCharge
      #   Fineract::Api::Org::CreateCharge.create()
      #
      class CreateCharge < AuthorisedBase
        post :create, "/charges", rubify_names: true
      end
    end
  end
end
