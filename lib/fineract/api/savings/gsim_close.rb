# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimClose
      #   Fineract::Api::Savings::GsimClose.close(id: 1)
      #
      class GsimClose < AuthorisedBase
        post :close, "/savingsaccounts/gsimcommands/:id?command=close", rubify_names: true
      end
    end
  end
end
