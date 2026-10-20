# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::GetAccount
      #   Fineract::Api::Shares::GetAccount.find(id: 1)
      #
      class GetAccount < AuthorisedBase
        get :find, "/accounts/share/:id", rubify_names: true
      end
    end
  end
end
