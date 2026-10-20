# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdateCode
      #   Fineract::Api::System::UpdateCode.save(id: 1)
      #
      class UpdateCode < AuthorisedBase
        put :save, "/codes/:id", rubify_names: true
      end
    end
  end
end
