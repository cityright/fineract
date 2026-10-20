# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::ListAccountingRules
      #   Fineract::Api::Accounting::ListAccountingRules.all()
      #
      class ListAccountingRules < AuthorisedBase
        get :all, "/accountingrules", rubify_names: true
      end
    end
  end
end
