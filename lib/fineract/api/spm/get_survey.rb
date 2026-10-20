# frozen_string_literal: true

module Fineract
  module Api
    module Spm
      # @example Spm::GetSurvey
      #   Fineract::Api::Spm::GetSurvey.find(id: 1)
      #
      class GetSurvey < AuthorisedBase
        get :find, "/surveys/:id", rubify_names: true
      end
    end
  end
end
