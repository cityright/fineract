# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateHoliday
      #   Fineract::Api::Org::CreateHoliday.create()
      #
      class CreateHoliday < AuthorisedBase
        post :create, "/holidays", rubify_names: true
      end
    end
  end
end
