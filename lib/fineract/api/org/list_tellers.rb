# frozen_string_literal: true

module Fineract
  module Api
    module Org
      # @example Org::ListTellers
      #   Fineract::Api::Org::ListTellers.all()
      #
      class ListTellers < AuthorisedBase
        get :all, "/tellers", rubify_names: true
      end
    end
  end
end
