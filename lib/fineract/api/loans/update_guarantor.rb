# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::UpdateGuarantor
      #   Fineract::Api::Loans::UpdateGuarantor.save(id: 1)
      #
      class UpdateGuarantor < AuthorisedBase
        put :save, "/loans/:id/guarantors/:guarantorId", rubify_names: true
      end
    end
  end
end
