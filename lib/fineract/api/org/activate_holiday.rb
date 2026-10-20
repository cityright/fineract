# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ActivateHoliday
      #   Fineract::Api::Org::ActivateHoliday.activate(id: 1)
      #
      class ActivateHoliday < AuthorisedBase
        post :activate, "/holidays/:id?command=activate", rubify_names: true
      end
    end
  end
end
