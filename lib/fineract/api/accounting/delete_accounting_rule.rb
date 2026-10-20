# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::DeleteAccountingRule
      #   Fineract::Api::Accounting::DeleteAccountingRule.remove(id: 1)
      #
      class DeleteAccountingRule < AuthorisedBase
        delete :remove, "/accountingrules/:id", rubify_names: true
      end
    end
  end
end
