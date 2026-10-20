# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::UnassignLoanOfficer
      #   Fineract::Api::Loans::UnassignLoanOfficer.unassign_officer(id: 1)
      #
      class UnassignLoanOfficer < AuthorisedBase
        post :unassign_officer, "/loans/:id?command=unassignLoanOfficer", rubify_names: true
      end
    end
  end
end
