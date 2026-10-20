# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::ListStandingInstructions
      #   Fineract::Api::Client::ListStandingInstructions.all()
      #
      class ListStandingInstructions < AuthorisedBase
        get :all, "/standinginstructions", rubify_names: true
      end
    end
  end
end
