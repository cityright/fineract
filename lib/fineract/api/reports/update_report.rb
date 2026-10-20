# frozen_string_literal: true

module Fineract
  module Api
    module Reports
      # @example Reports::UpdateReport
      #   Fineract::Api::Reports::UpdateReport.save(id: 1)
      #
      class UpdateReport < AuthorisedBase
        put :save, "/reports/:id", rubify_names: true
      end
    end
  end
end
