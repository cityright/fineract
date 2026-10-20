# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::DeleteGlAccount
      #   Fineract::Api::Accounting::DeleteGlAccount.remove(id: 1)
      #
      class DeleteGlAccount < AuthorisedBase
        delete :remove, "/glaccounts/:id", rubify_names: true
      end
    end
  end
end
