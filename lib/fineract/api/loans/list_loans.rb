# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::ListLoans
      #   Fineract::Api::Loans::ListLoans.all()
      #
      class ListLoans < AuthorisedBase
        get :all, "/loans", rubify_names: true
      end
    end
  end
end
