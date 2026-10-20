# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::ListCenters
      #   Fineract::Api::Centers::ListCenters.all()
      #
      class ListCenters < AuthorisedBase
        get :all, "/centers", rubify_names: true
      end
    end
  end
end
