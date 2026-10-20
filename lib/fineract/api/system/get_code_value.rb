# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetCodeValue
      #   Fineract::Api::System::GetCodeValue.find(id: 1)
      #
      class GetCodeValue < AuthorisedBase
        get :find, "/codes/:id/codevalues/:codeValueId", rubify_names: true
      end
    end
  end
end
