# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::RetrieveOffice
      #   Fineract::Api::Org::RetrieveOffice.find(id)
      #
      #
      class RetrieveOffice < AuthorisedBase
        get :find, "/offices/:id", rubify_names: true
      end
    end
  end
end
