# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::DeleteCode
      #   Fineract::Api::System::DeleteCode.remove(id: 1)
      #
      class DeleteCode < AuthorisedBase
        delete :remove, "/codes/:id", rubify_names: true
      end
    end
  end
end
