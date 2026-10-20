# frozen_string_literal: true

module Fineract
  module Api
    module Reports
      # @example Reports::GetReport
      #   Fineract::Api::Reports::GetReport.find(id: 1)
      #
      class GetReport < AuthorisedBase
        get :find, "/reports/:id", rubify_names: true
      end
    end
  end
end
