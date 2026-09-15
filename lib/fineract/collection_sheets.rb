# frozen_string_literal: true

module Fineract
  class CollectionSheets < Resource
    FIELDS = { office_id: "officeId", transaction_date: "transactionDate", actual_disbursement_date: "actualDisbursementDate", date_format: "dateFormat", locale: "locale", bulk_disbursement_transactions: "bulkDisbursementTransactions" }.freeze
    def generate(**a) = call(:generate_collection_sheet, body: mapped_keys(a, FIELDS), idempotent: false)
    alias save generate
  end
end
