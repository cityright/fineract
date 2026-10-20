# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GlimApprove
      #   Fineract::Api::Loans::GlimApprove.approve(id: 1)
      #
      class GlimApprove < AuthorisedBase
        post :approve, "/loans/glimAccount/:id?command=approve", rubify_names: true
      end
    end
  end
end
