# frozen_string_literal: true

module Fineract
  module Api
    module Loans
      # @example Loans::AssignLoanOfficer
      #   Fineract::Api::Loans::AssignLoanOfficer.assign_officer(id: 1)
      #
      class AssignLoanOfficer < AuthorisedBase
        post :assign_officer, "/loans/:id?command=assignLoanOfficer", rubify_names: true
      end
    end
  end
end
