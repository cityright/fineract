# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::CreateCodeValue
      #   Fineract::Api::System::CreateCodeValue.create(id: 1)
      #
      class CreateCodeValue < AuthorisedBase
        post :create, "/codes/:id/codevalues", rubify_names: true
      end
    end
  end
end
