# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::CreateStandingInstruction
      #   Fineract::Api::Client::CreateStandingInstruction.create()
      #
      class CreateStandingInstruction < AuthorisedBase
        post :create, "/standinginstructions", rubify_names: true
      end
    end
  end
end
