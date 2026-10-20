# frozen_string_literal: true

module Fineract
  module Api
    module System
      # @example System::Search
      #   Fineract::Api::System::Search.all()
      #
      class Search < AuthorisedBase
        get :all, "/search", rubify_names: true
      end
    end
  end
end
