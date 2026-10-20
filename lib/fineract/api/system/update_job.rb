# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdateJob
      #   Fineract::Api::System::UpdateJob.save(id: 1)
      #
      class UpdateJob < AuthorisedBase
        put :save, "/jobs/:id", rubify_names: true
      end
    end
  end
end
