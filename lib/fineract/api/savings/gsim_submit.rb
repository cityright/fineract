# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimSubmit
      #   Fineract::Api::Savings::GsimSubmit.create()
      #
      class GsimSubmit < AuthorisedBase
        post :create, "/savingsaccounts/gsim", rubify_names: true
      end
    end
  end
end
