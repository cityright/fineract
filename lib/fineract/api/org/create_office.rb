# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Org
      # @example Org::CreateOffice
      #   Fineract::Api::Org::CreateOffice.create(
      #    "name": "Migori", "openingDate": "01 September 2022", "parentId": 1, "dateFormat": "dd MMMM yyyy","locale": "en"
      #   )
      #

      class CreateOffice < AuthorisedBase
        validates :name, presence: true
        validates :openingDate, presence: true
        validates :parentId, presence: true

        post :create, "/offices"
      end
    end
  end
end
# rubocop:enable Layout/LineLength
