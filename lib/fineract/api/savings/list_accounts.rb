# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::ListAccounts
      #   Fineract::Api::Savings::ListAccounts.all()
      #
      class ListAccounts < AuthorisedBase
        get :all, "/savingsaccounts", rubify_names: true
      end
    end
  end
end
