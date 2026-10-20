# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::StandingInstructionHistory
      #   Fineract::Api::Client::StandingInstructionHistory.history()
      #
      class StandingInstructionHistory < AuthorisedBase
        get :history, "/standinginstructionrunhistory", rubify_names: true
      end
    end
  end
end
