# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::ApproveLoan
      #   Fineract::Api::Loans::ApproveLoan.approve(id: 1)
      #
      class ApproveLoan < AuthorisedBase
        post :approve, "/loans/:id?command=approve", rubify_names: true
      end
    end
  end
end
