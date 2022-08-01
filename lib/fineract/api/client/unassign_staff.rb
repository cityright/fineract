# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UnassignStaff
      #   Fineract::Api::Client::UnassignStaff.create(id:10, "staffId": "1")
      #
      #
      class UnassignStaff < AuthorisedBase
        post :create, "/clients/:id?command=unassignStaff", rubify_names: true
      end
    end
  end
end
