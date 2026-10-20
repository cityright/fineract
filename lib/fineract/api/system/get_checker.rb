# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetChecker
      #   Fineract::Api::System::GetChecker.find(id: 1)
      #
      class GetChecker < AuthorisedBase
        get :find, "/makercheckers/:id", rubify_names: true
      end
    end
  end
end
