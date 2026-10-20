# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ListJobs
      #   Fineract::Api::System::ListJobs.all()
      #
      class ListJobs < AuthorisedBase
        get :all, "/jobs", rubify_names: true
      end
    end
  end
end
