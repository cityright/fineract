# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ListHooks
      #   Fineract::Api::System::ListHooks.all()
      #
      class ListHooks < AuthorisedBase
        get :all, "/hooks", rubify_names: true
      end
    end
  end
end
