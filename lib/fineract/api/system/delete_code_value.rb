# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::DeleteCodeValue
      #   Fineract::Api::System::DeleteCodeValue.remove(id: 1)
      #
      class DeleteCodeValue < AuthorisedBase
        delete :remove, "/codes/:id/codevalues/:codeValueId", rubify_names: true
      end
    end
  end
end
