# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::GetFrequentPosting
      #   Fineract::Api::Accounting::GetFrequentPosting.find(id: 1)
      #
      class GetFrequentPosting < AuthorisedBase
        get :find, "/frequentpostings/:id", rubify_names: true
      end
    end
  end
end
