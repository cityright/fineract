# frozen_string_literal: true

module Fineract
  module Api
    module Accounting
      # @example Accounting::ReverseJournalEntry
      #   Fineract::Api::Accounting::ReverseJournalEntry.reverse(id: 1)
      #
      class ReverseJournalEntry < AuthorisedBase
        post :reverse, "/journalentries/:transactionId/reversal", rubify_names: true
      end
    end
  end
end
