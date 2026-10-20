# frozen_string_literal: true

module Fineract
  module Api
    module Shares
      # @example Shares::UpdateAccount
      #   Fineract::Api::Shares::UpdateAccount.save(id: 1)
      #
      class UpdateAccount < AuthorisedBase
        put :save, "/accounts/share/:id", rubify_names: true
      end
    end
  end
end
