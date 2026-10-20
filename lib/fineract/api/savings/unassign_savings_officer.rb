# frozen_string_literal: true

module Fineract
  module Api
    module Savings
      # @example Savings::UnassignSavingsOfficer
      #   Fineract::Api::Savings::UnassignSavingsOfficer.unassign_officer(id: 1)
      #
      class UnassignSavingsOfficer < AuthorisedBase
        post :unassign_officer, "/savingsaccounts/:id?command=unassignSavingsOfficer", rubify_names: true
      end
    end
  end
end
