# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::GetAccounts
      #   Fineract::Api::Centers::GetAccounts.find(id: 1)
      #
      class GetAccounts < AuthorisedBase
        get :find, "/centers/:id/accounts", rubify_names: true
      end
    end
  end
end
