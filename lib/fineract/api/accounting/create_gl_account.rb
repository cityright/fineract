# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::CreateGlAccount
      #   Fineract::Api::Accounting::CreateGlAccount.create()
      #
      class CreateGlAccount < AuthorisedBase
        post :create, "/glaccounts", rubify_names: true
      end
    end
  end
end
