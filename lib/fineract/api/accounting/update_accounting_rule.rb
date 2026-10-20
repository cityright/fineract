# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::UpdateAccountingRule
      #   Fineract::Api::Accounting::UpdateAccountingRule.save(id: 1)
      #
      class UpdateAccountingRule < AuthorisedBase
        put :save, "/accountingrules/:id", rubify_names: true
      end
    end
  end
end
