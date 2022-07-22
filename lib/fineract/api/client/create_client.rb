
# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client::GetClient
        #   Fineract::Api::Client::CreatClient.create()
        # 
        #
        class CreateClient < AuthorisedBase
       
           # order of the JSON payload
          # {"firstname": "John", "lastname": "Doe", "fullname": "John Doe","officeId": 1,"active": true, "dateFormat": "dd MMMM yyyy","locale": "en","activationDate": "04 July 2022"}
          # if the JSON is not in this exact order, Hash Mismatch will result
  
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
  