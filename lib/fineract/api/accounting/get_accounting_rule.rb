# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::GetAccountingRule
      #   Fineract::Api::Accounting::GetAccountingRule.find(id: 1)
      #
      class GetAccountingRule < AuthorisedBase
        get :find, "/accountingrules/:id", rubify_names: true
      end
    end
  end
end
