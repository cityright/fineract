# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListFunds
      #   Fineract::Api::Org::ListFunds.all()
      #
      class ListFunds < AuthorisedBase
        get :all, "/funds", rubify_names: true
      end
    end
  end
end
