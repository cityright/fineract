# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::CreateFund
      #   Fineract::Api::Org::CreateFund.create()
      #
      class CreateFund < AuthorisedBase
        post :create, "/funds", rubify_names: true
      end
    end
  end
end
