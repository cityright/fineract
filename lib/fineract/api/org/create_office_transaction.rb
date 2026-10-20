# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateOfficeTransaction
      #   Fineract::Api::Org::CreateOfficeTransaction.create()
      #
      class CreateOfficeTransaction < AuthorisedBase
        post :create, "/officetransactions", rubify_names: true
      end
    end
  end
end
