# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ListAccountNumberFormats
      #   Fineract::Api::System::ListAccountNumberFormats.all()
      #
      class ListAccountNumberFormats < AuthorisedBase
        get :all, "/accountnumberformats", rubify_names: true
      end
    end
  end
end
