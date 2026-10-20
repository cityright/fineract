# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::GetPermission
      #   Fineract::Api::Users::GetPermission.find(id: 1)
      #
      class GetPermission < AuthorisedBase
        get :find, "/permissions/:id", rubify_names: true
      end
    end
  end
end
