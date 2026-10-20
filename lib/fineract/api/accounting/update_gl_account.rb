# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::UpdateGlAccount
      #   Fineract::Api::Accounting::UpdateGlAccount.save(id: 1)
      #
      class UpdateGlAccount < AuthorisedBase
        put :save, "/glaccounts/:id", rubify_names: true
      end
    end
  end
end
