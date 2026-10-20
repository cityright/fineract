# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::GetJournalEntry
      #   Fineract::Api::Accounting::GetJournalEntry.find(id: 1)
      #
      class GetJournalEntry < AuthorisedBase
        get :find, "/journalentries/:id", rubify_names: true
      end
    end
  end
end
