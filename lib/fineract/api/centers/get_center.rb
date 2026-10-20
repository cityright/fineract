# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::GetCenter
      #   Fineract::Api::Centers::GetCenter.find(id: 1)
      #
      class GetCenter < AuthorisedBase
        get :find, "/centers/:id", rubify_names: true
      end
    end
  end
end
