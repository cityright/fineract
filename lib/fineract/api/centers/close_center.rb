# frozen_string_literal: true

module Fineract
  module Api
    module Centers
      # @example Centers::CloseCenter
      #   Fineract::Api::Centers::CloseCenter.close(id: 1)
      #
      class CloseCenter < AuthorisedBase
        post :close, "/centers/:id?command=close", rubify_names: true
      end
    end
  end
end
