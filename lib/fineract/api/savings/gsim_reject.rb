# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimReject
      #   Fineract::Api::Savings::GsimReject.reject(id: 1)
      #
      class GsimReject < AuthorisedBase
        post :reject, "/savingsaccounts/gsimcommands/:id?command=reject", rubify_names: true
      end
    end
  end
end
