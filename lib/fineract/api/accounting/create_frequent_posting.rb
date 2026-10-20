# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::CreateFrequentPosting
      #   Fineract::Api::Accounting::CreateFrequentPosting.create()
      #
      class CreateFrequentPosting < AuthorisedBase
        post :create, "/frequentpostings", rubify_names: true
      end
    end
  end
end
