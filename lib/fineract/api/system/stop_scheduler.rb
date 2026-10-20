# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::StopScheduler
      #   Fineract::Api::System::StopScheduler.stop()
      #
      class StopScheduler < AuthorisedBase
        post :stop, "/scheduler?command=stop", rubify_names: true
      end
    end
  end
end
