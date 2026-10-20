# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::CloseAccount
      #   Fineract::Api::Shares::CloseAccount.close(id: 1)
      #
      class CloseAccount < AuthorisedBase
        post :close, "/accounts/share/:id?command=close", rubify_names: true
      end
    end
  end
end
