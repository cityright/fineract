# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::GetGlAccount
      #   Fineract::Api::Accounting::GetGlAccount.find(id: 1)
      #
      class GetGlAccount < AuthorisedBase
        get :find, "/glaccounts/:id", rubify_names: true
      end
    end
  end
end
