# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListStaff
      #   Fineract::Api::Org::ListStaff.all()
      #
      class ListStaff < AuthorisedBase
        get :all, "/staff", rubify_names: true
      end
    end
  end
end
