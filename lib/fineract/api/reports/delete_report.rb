# frozen_string_literal: true

module Fineract
  module Api
    module Reports
      # @example Reports::DeleteReport
      #   Fineract::Api::Reports::DeleteReport.remove(id: 1)
      #
      class DeleteReport < AuthorisedBase
        delete :remove, "/reports/:id", rubify_names: true
      end
    end
  end
end
