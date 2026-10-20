# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::UpdateFrequentPosting
      #   Fineract::Api::Accounting::UpdateFrequentPosting.save(id: 1)
      #
      class UpdateFrequentPosting < AuthorisedBase
        put :save, "/frequentpostings/:id", rubify_names: true
      end
    end
  end
end
