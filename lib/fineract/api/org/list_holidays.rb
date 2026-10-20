# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListHolidays
      #   Fineract::Api::Org::ListHolidays.all()
      #
      class ListHolidays < AuthorisedBase
        get :all, "/holidays", rubify_names: true
      end
    end
  end
end
