# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::GetAudit
      #   Fineract::Api::System::GetAudit.find(id: 1)
      #
      class GetAudit < AuthorisedBase
        get :find, "/audits/:id", rubify_names: true
      end
    end
  end
end
