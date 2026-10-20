# frozen_string_literal: true

module Fineract
  module Api
    module Spm
      # @example Spm::CreateClientSurvey
      #   Fineract::Api::Spm::CreateClientSurvey.create(id: 1)
      #
      class CreateClientSurvey < AuthorisedBase
        post :create, "/surveys/:id/clients/:clientId", rubify_names: true
      end
    end
  end
end
