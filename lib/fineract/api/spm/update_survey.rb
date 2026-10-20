# frozen_string_literal: true

module Fineract
  module Api
    module Spm
      # @example Spm::UpdateSurvey
      #   Fineract::Api::Spm::UpdateSurvey.save(id: 1)
      #
      class UpdateSurvey < AuthorisedBase
        put :save, "/surveys/:id", rubify_names: true
      end
    end
  end
end
