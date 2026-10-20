# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::UpdateCodeValue
      #   Fineract::Api::System::UpdateCodeValue.save(id: 1)
      #
      class UpdateCodeValue < AuthorisedBase
        put :save, "/codes/:id/codevalues/:codeValueId", rubify_names: true
      end
    end
  end
end
