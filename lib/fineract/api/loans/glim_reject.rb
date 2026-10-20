# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GlimReject
      #   Fineract::Api::Loans::GlimReject.reject(id: 1)
      #
      class GlimReject < AuthorisedBase
        post :reject, "/loans/glimAccount/:id?command=reject", rubify_names: true
      end
    end
  end
end
