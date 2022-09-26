# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Groups
      # @example Groups::CreateGroup
      #   Fineract::Api::Groups::CreateGroup.create(
      #    "name": "Some Group", "active": true, "activationDate": "01 September 2022", "officeId": 1, "dateFormat": "dd MMMM yyyy","locale": "en"
      #   )
      #

      class CreateGroup < AuthorisedBase
        validates :name, presence: true
        validates :officeId, presence: true
        validates :active, presence: true
        validates :activationDate, presence: true # if :active is true

        post :create, "/groups"
      end
    end
  end
end
# rubocop:enable Layout/LineLength
