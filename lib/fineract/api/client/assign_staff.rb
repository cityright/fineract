# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::AssignStaff
      #   Fineract::Api::Client::AssignStaff.create(id:10, "staffId": "1")
      #
      #
      class AssignStaff < AuthorisedBase
        post :assign, "/clients/:id?command=assignStaff", rubify_names: true
      end
    end
  end
end
