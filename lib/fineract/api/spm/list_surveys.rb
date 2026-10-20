# frozen_string_literal: true

module Fineract
  module Api
    module Spm
      # @example Spm::ListSurveys
      #   Fineract::Api::Spm::ListSurveys.all()
      #
      class ListSurveys < AuthorisedBase
        get :all, "/surveys", rubify_names: true
      end
    end
  end
end
