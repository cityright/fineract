# frozen_string_literal: true

module Fineract
  module Api
    module Reports
      # @example Reports::CreateReport
      #   Fineract::Api::Reports::CreateReport.create()
      #
      class CreateReport < AuthorisedBase
        post :create, "/reports", rubify_names: true
      end
    end
  end
end
