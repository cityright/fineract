# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::GsimModify
      #   Fineract::Api::Savings::GsimModify.save()
      #
      class GsimModify < AuthorisedBase
        put :save, "/savingsaccounts/gsim", rubify_names: true
      end
    end
  end
end
