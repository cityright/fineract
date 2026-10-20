# frozen_string_literal: true

module Fineract
  module Api
    module Spm
      # @example Spm::CreateSurvey
      #   Fineract::Api::Spm::CreateSurvey.create()
      #
      class CreateSurvey < AuthorisedBase
        post :create, "/surveys", rubify_names: true
      end
    end
  end
end
