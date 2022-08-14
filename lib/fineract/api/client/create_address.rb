# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module Fineract
  module Api
    module Client
      # @example Client::CreateAddress
      #  params = {
      #    "id", 10,
      #   "street":"Ipca",
      #   "addressLine1":"Kandivali",
      #   "addressLine2":"plot47",
      #   "addressLine3":"charkop",
      #   "city":"Mumbai",
      #   "stateProvinceId":800,
      #   "countryId":802,
      #   "postalCode":"400064"
      #   }
      #   Fineract::Api::Client::CreateAddress.create(params)
      #   
      #
      class CreateAddress < AuthorisedBase
        before_request :format_create_params
        post :create, "/client/:id/addresses"

        def format_create_params(name, request)
          return unless name == :create

          # params = HashWithIndifferentAccess.new(request.post_params)
          # type = params.delete(:type)

          # request.url = request.url + "?type=#{type}"
        end
      end
    end
  end
end
# rubocop:enable Layout/LineLength
