# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GlimDisburse
      #   Fineract::Api::Loans::GlimDisburse.disburse(id: 1)
      #
      class GlimDisburse < AuthorisedBase
        post :disburse, "/loans/glimAccount/:id?command=disburse", rubify_names: true
      end
    end
  end
end
