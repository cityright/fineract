# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ListCodes
      #   Fineract::Api::System::ListCodes.all()
      #
      class ListCodes < AuthorisedBase
        get :all, "/codes", rubify_names: true
      end
    end
  end
end
