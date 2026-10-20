# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::ActivateAccount
      #   Fineract::Api::Shares::ActivateAccount.activate(id: 1)
      #
      class ActivateAccount < AuthorisedBase
        post :activate, "/accounts/share/:id?command=activate", rubify_names: true
      end
    end
  end
end
