# frozen_string_literal: true

module Fineract
  module Api
    module Reports
      # @example Reports::RunReport
      #   Fineract::Api::Reports::RunReport.all(id: 1)
      #
      class RunReport < AuthorisedBase
        get :all, "/runreports/:reportName", rubify_names: true
      end
    end
  end
end
