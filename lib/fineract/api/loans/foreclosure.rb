# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::Foreclosure
      #   Fineract::Api::Loans::Foreclosure.foreclose(id: 1)
      #
      class Foreclosure < AuthorisedBase
        post :foreclose, "/loans/:id/transactions?command=foreclosure", rubify_names: true
      end
    end
  end
end
