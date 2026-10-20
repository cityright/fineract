# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::ListAudits
      #   Fineract::Api::System::ListAudits.all()
      #
      class ListAudits < AuthorisedBase
        get :all, "/audits", rubify_names: true
      end
    end
  end
end
