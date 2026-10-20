# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::DeleteFrequentPosting
      #   Fineract::Api::Accounting::DeleteFrequentPosting.remove(id: 1)
      #
      class DeleteFrequentPosting < AuthorisedBase
        delete :remove, "/frequentpostings/:id", rubify_names: true
      end
    end
  end
end
