# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::ListAccounts
      #   Fineract::Api::Shares::ListAccounts.all()
      #
      class ListAccounts < AuthorisedBase
        get :all, "/shareaccounts", rubify_names: true
      end
    end
  end
end
