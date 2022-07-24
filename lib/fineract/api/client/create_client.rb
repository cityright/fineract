# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::CreateClient
      #   Fineract::Api::Client::CreateClient.create(
      #    "firstname": "Jack", "lastname": "Dorsey","officeId": 1,"active": false, "dateFormat": "dd MMMM yyyy","locale": "en"
      #   )
      #

      class CreateClient < AuthorisedBase
        post :create, "/clients", rubify_names: true

        validates :firstname, presence: true
        validates :lastname, presence: true
        validates :officeId, presence: true
        validates :active, presence: true
        validates :dateFormat, presence: true
        validates :locale, presence: true
        validates :activationDate, presence: true
      end
    end
  end
end


Fineract::Api::Client::CreateClient.create("firstname": "Johnny", "lastname": "Doed", "officeId": 1,"active": true, "dateFormat": "dd MMMM yyyy","locale": "en","activationDate": "04 July 2022")