# frozen_string_literal: true

module Fineract
  module Api
    module SelfService
      # @example SelfService::ListLoans
      #   Fineract::Api::SelfService::ListLoans.all()
      #
      class ListLoans < AuthorisedBase
        get :all, "/self/loans", rubify_names: true
      end
    end
  end
end
