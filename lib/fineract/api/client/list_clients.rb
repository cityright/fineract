# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client::GetClients
        #   Fineract::Api::Client::ListClients.all(
        #     paybill: '172300', amount: 100, phone_number: "254722000000", remarks: "Some Remark",
        #     occassion: "Some Occasion"
        #   )
        #
        class ListClients < AuthorisedBase
          before_request :camelize_params
  
          get :all, '/clients', rubify_names: true
          
        end
      end
    end
  end
  