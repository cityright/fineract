# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ListChecker
      #   Fineract::Api::System::ListChecker.all()
      #
      class ListChecker < AuthorisedBase
        get :all, "/makercheckers", rubify_names: true
      end
    end
  end
end
