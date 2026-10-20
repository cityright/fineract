# frozen_string_literal: true

module Fineract
  module Api
    module Spm
      # @example Spm::DeleteSurvey
      #   Fineract::Api::Spm::DeleteSurvey.remove(id: 1)
      #
      class DeleteSurvey < AuthorisedBase
        delete :remove, "/surveys/:id", rubify_names: true
      end
    end
  end
end
