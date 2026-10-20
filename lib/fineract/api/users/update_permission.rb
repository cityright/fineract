# frozen_string_literal: true

module Fineract
  module Api
    module Users
      # @example Users::UpdatePermission
      #   Fineract::Api::Users::UpdatePermission.save(id: 1)
      #
      class UpdatePermission < AuthorisedBase
        put :save, "/permissions/:id", rubify_names: true
      end
    end
  end
end
