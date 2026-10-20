# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimActivate
      #   Fineract::Api::Savings::GsimActivate.activate(id: 1)
      #
      class GsimActivate < AuthorisedBase
        post :activate, "/savingsaccounts/gsimcommands/:id?command=activate", rubify_names: true
      end
    end
  end
end
