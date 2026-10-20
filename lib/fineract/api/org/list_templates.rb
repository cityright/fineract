# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListTemplates
      #   Fineract::Api::Org::ListTemplates.all()
      #
      class ListTemplates < AuthorisedBase
        get :all, "/templates", rubify_names: true
      end
    end
  end
end
