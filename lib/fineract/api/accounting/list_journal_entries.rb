# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::ListJournalEntries
      #   Fineract::Api::Accounting::ListJournalEntries.all()
      #
      class ListJournalEntries < AuthorisedBase
        get :all, "/journalentries", rubify_names: true
      end
    end
  end
end
