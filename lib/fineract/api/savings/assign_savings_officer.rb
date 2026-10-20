# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::AssignSavingsOfficer
      #   Fineract::Api::Savings::AssignSavingsOfficer.assign_officer(id: 1)
      #
      class AssignSavingsOfficer < AuthorisedBase
        post :assign_officer, "/savingsaccounts/:id?command=assignSavingsOfficer", rubify_names: true
      end
    end
  end
end
