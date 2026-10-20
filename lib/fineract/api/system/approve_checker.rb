# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ApproveChecker
      #   Fineract::Api::System::ApproveChecker.approve(id: 1)
      #
      class ApproveChecker < AuthorisedBase
        post :approve, "/makercheckers/:id?command=approve", rubify_names: true
      end
    end
  end
end
