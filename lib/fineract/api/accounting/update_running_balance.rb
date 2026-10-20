# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::UpdateRunningBalance
      #   Fineract::Api::Accounting::UpdateRunningBalance.update_balance()
      #
      class UpdateRunningBalance < AuthorisedBase
        post :update_balance, "/journalentries?command=updateRunningBalance", rubify_names: true
      end
    end
  end
end
