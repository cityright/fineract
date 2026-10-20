# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::RunJob
      #   Fineract::Api::System::RunJob.run(id: 1)
      #
      class RunJob < AuthorisedBase
        post :run, "/jobs/:id?command=run", rubify_names: true
      end
    end
  end
end
