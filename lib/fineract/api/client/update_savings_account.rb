# frozen_string_literal: true

module Fineract
  module Api
    module Client
      # @example Client::UpdateSavingsAccount
      #   params = { "id": 1, "savingsAccountId": "22" }
      #   Fineract::Api::Client::UpdateSavingsAccount.save(params)
      #
      class UpdateSavingsAccount < AuthorisedBase
        put :save, "/clients/:id?command=updateSavingsAccount", rubify_names: true
      end
    end
  end
end
