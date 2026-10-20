# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::CreateCenter
      #   Fineract::Api::Centers::CreateCenter.create()
      #
      class CreateCenter < AuthorisedBase
        post :create, "/centers", rubify_names: true
      end
    end
  end
end
