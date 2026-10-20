# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::CreateAccount
      #   Fineract::Api::Shares::CreateAccount.create()
      #
      class CreateAccount < AuthorisedBase
        post :create, "/shareaccounts", rubify_names: true
      end
    end
  end
end
