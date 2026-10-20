# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::GetHoliday
      #   Fineract::Api::Org::GetHoliday.find(id: 1)
      #
      class GetHoliday < AuthorisedBase
        get :find, "/holidays/:id", rubify_names: true
      end
    end
  end
end
