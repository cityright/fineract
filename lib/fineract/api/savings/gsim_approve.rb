# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimApprove
      #   Fineract::Api::Savings::GsimApprove.approve(id: 1)
      #
      class GsimApprove < AuthorisedBase
        post :approve, "/savingsaccounts/gsimcommands/:id?command=approve", rubify_names: true
      end
    end
  end
end
