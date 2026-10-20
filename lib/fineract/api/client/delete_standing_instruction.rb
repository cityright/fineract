# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::DeleteStandingInstruction
      #   Fineract::Api::Client::DeleteStandingInstruction.remove(id: 1)
      #
      class DeleteStandingInstruction < AuthorisedBase
        delete :remove, "/standinginstructions/:id", rubify_names: true
      end
    end
  end
end
