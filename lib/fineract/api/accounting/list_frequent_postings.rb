# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::ListFrequentPostings
      #   Fineract::Api::Accounting::ListFrequentPostings.all()
      #
      class ListFrequentPostings < AuthorisedBase
        get :all, "/frequentpostings", rubify_names: true
      end
    end
  end
end
