# frozen_string_literal: true

module Fineract
  module Api
    module Groups
      # @example Groups::RetrieveGroupTemplate
      #   Fineract::Api::Groups::RetrieveGroupTemplate.get()
      #
      #
      class RetrieveGroupTemplate < AuthorisedBase
        before_request :camelize_params

        get :get, "/groups/template", rubify_names: true
      end
    end
  end
end
