# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetCode
      #   Fineract::Api::System::GetCode.find(id: 1)
      #
      class GetCode < AuthorisedBase
        get :find, "/codes/:id", rubify_names: true
      end
    end
  end
end
