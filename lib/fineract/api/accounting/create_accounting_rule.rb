# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::CreateAccountingRule
      #   Fineract::Api::Accounting::CreateAccountingRule.create()
      #
      class CreateAccountingRule < AuthorisedBase
        post :create, "/accountingrules", rubify_names: true
      end
    end
  end
end
