# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UpdateStandingInstruction
      #   Fineract::Api::Client::UpdateStandingInstruction.save(id: 1)
      #
      class UpdateStandingInstruction < AuthorisedBase
        put :save, "/standinginstructions/:id", rubify_names: true
      end
    end
  end
end
