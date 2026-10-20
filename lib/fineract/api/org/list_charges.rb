# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListCharges
      #   Fineract::Api::Org::ListCharges.all()
      #
      class ListCharges < AuthorisedBase
        get :all, "/charges", rubify_names: true
      end
    end
  end
end
