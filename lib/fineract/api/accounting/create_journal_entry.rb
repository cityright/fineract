# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::CreateJournalEntry
      #   Fineract::Api::Accounting::CreateJournalEntry.create()
      #
      class CreateJournalEntry < AuthorisedBase
        post :create, "/journalentries", rubify_names: true
      end
    end
  end
end
