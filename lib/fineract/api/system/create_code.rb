# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::CreateCode
      #   Fineract::Api::System::CreateCode.create()
      #
      class CreateCode < AuthorisedBase
        post :create, "/codes", rubify_names: true
      end
    end
  end
end
