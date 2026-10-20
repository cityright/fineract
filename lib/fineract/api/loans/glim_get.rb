# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::GlimGet
      #   Fineract::Api::Loans::GlimGet.find(id: 1)
      #
      class GlimGet < AuthorisedBase
        get :find, "/loans/glimAccount/:id", rubify_names: true
      end
    end
  end
end
