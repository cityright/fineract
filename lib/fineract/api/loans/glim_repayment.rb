# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GlimRepayment
      #   Fineract::Api::Loans::GlimRepayment.repayment(id: 1)
      #
      class GlimRepayment < AuthorisedBase
        post :repayment, "/loans/glimAccount/:id?command=glimrepayment", rubify_names: true
      end
    end
  end
end
