# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::ListGlAccounts
      #   Fineract::Api::Accounting::ListGlAccounts.all()
      #
      class ListGlAccounts < AuthorisedBase
        get :all, "/glaccounts", rubify_names: true
      end
    end
  end
end
