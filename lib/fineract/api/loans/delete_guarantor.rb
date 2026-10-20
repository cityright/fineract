# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::DeleteGuarantor
      #   Fineract::Api::Loans::DeleteGuarantor.remove(id: 1)
      #
      class DeleteGuarantor < AuthorisedBase
        delete :remove, "/loans/:id/guarantors/:guarantorId", rubify_names: true
      end
    end
  end
end
