# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::RejectAccount
      #   Fineract::Api::Shares::RejectAccount.reject(id: 1)
      #
      class RejectAccount < AuthorisedBase
        post :reject, "/accounts/share/:id?command=reject", rubify_names: true
      end
    end
  end
end
