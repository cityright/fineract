# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetScheduler
      #   Fineract::Api::System::GetScheduler.find()
      #
      class GetScheduler < AuthorisedBase
        get :find, "/scheduler", rubify_names: true
      end
    end
  end
end
