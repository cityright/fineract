# frozen_string_literal: true

module Fineract
  module Api
    module Spm
      # @example Spm::GetClientSurvey
      #   Fineract::Api::Spm::GetClientSurvey.find(id: 1)
      #
      class GetClientSurvey < AuthorisedBase
        get :find, "/surveys/:id/clients/:clientId", rubify_names: true
      end
    end
  end
end
