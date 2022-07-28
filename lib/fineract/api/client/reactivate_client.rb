# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client::ReactivateClient
        # Fineract::Api::Client::ReactivateClient.create(id: 10, "withdrawalDate": "28 November 2022", "withdrawalReasonId": 17, "locale":"en", "dateFormat":"dd MMMM yyyy")
        #
        class ReactivateClient < AuthorisedBase
          post :create, "/clients/:id?command=reactivate", rubify_names: true
        end
      end
    end
  end
  