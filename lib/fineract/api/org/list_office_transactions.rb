# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListOfficeTransactions
      #   Fineract::Api::Org::ListOfficeTransactions.all()
      #
      class ListOfficeTransactions < AuthorisedBase
        get :all, "/officetransactions", rubify_names: true
      end
    end
  end
end
