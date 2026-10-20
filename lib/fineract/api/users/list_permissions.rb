# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::ListPermissions
      #   Fineract::Api::Users::ListPermissions.all()
      #
      class ListPermissions < AuthorisedBase
        get :all, "/permissions", rubify_names: true
      end
    end
  end
end
