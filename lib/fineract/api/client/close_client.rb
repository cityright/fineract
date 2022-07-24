# frozen_string_literal: true

module Fineract
    module Api
      module Client
        # @example Client::CloseClient
        #   Fineract::Api::Client::CloseClient.find(id:1, "dateFormat":"dd MMMM yyyy","locale":"en","closureDate":"25 June 2013")
        #
        #
        class CloseClient < AuthorisedBase
          before_request :format_create_params
          post :create, "/clients/:id/?command=close", rubify_names: true

          private

          def format_create_params(name, request)
            return unless name == :create
  
            params = HashWithIndifferentAccess.new(request.post_params)
binding.pry
  
            request.post_params = params.merge(closureReasonId: "11")

          end
        end
      end
    end
  end
  