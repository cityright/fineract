# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetJob
      #   Fineract::Api::System::GetJob.find(id: 1)
      #
      class GetJob < AuthorisedBase
        get :find, "/jobs/:id", rubify_names: true
      end
    end
  end
end
