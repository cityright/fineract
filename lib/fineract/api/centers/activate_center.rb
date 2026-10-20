# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::ActivateCenter
      #   Fineract::Api::Centers::ActivateCenter.activate(id: 1)
      #
      class ActivateCenter < AuthorisedBase
        post :activate, "/centers/:id?command=activate", rubify_names: true
      end
    end
  end
end
