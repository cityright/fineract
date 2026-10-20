# frozen_string_literal: true

module Fineract
  module Api
    module Reports
      # @example Reports::ListReports
      #   Fineract::Api::Reports::ListReports.all()
      #
      class ListReports < AuthorisedBase
        get :all, "/reports", rubify_names: true
      end
    end
  end
end
