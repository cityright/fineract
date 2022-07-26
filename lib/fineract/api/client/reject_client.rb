# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client::RejectClient
        #   Fineract::Api::Client::RejectClient.create(id:10, "dateFormat":"dd MMMM yyyy","locale":"en","rejectionDate": "28 November 2014", "rejectionReasonId":16)
        #
        #
        class RejectClient < AuthorisedBase
        
          post :create, "/clients/:id/?command=reject", rubify_names: true
          
        end
      end
    end
  end
  