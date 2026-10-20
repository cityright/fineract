# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::RejectChecker
      #   Fineract::Api::System::RejectChecker.reject(id: 1)
      #
      class RejectChecker < AuthorisedBase
        post :reject, "/makercheckers/:id?command=reject", rubify_names: true
      end
    end
  end
end
