# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListOffices
      #   Fineract::Api::Org::ListOffices.all()
      #
      class ListOffices < AuthorisedBase
        get :all, "/offices", rubify_names: true
      end
    end
  end
end
