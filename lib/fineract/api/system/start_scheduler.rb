# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::StartScheduler
      #   Fineract::Api::System::StartScheduler.start()
      #
      class StartScheduler < AuthorisedBase
        post :start, "/scheduler?command=start", rubify_names: true
      end
    end
  end
end
