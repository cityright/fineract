# frozen_string_literal: true

module Fineract
  class Accounting < Resource
    ACCOUNT_FIELDS = { description: "description", gl_code: "glCode", manual_entries_allowed: "manualEntriesAllowed", name: "name", parent_id: "parentId", tag_id: "tagId", type: "type", usage: "usage" }.freeze
    RULE_FIELDS = { account_to_credit: "accountToCredit", account_to_debit: "accountToDebit", description: "description", name: "name", office_id: "officeId" }.freeze
    CLOSURE_FIELDS = { closing_date: "closingDate", comments: "comments", date_format: "dateFormat", locale: "locale", office_id: "officeId" }.freeze
    JOURNAL_FIELDS = { account_number: "accountNumber", accounting_rule_id: "accountingRuleId", amount: "amount", bank_number: "bankNumber", check_number: "checkNumber", comments: "comments", credits: "credits", currency_code: "currencyCode", date_format: "dateFormat", debits: "debits", external_asset_owner: "externalAssetOwner", locale: "locale", office_id: "officeId", payment_type_id: "paymentTypeId", receipt_number: "receiptNumber", reference_number: "referenceNumber", routing_code: "routingCode", transaction_date: "transactionDate" }.freeze
    MAPPING_FIELDS = { financial_activity_id: "financialActivityId", gl_account_id: "glAccountId" }.freeze
    QUERY_FIELDS = { search_param: "searchParam", manual_entries_allowed: "manualEntriesAllowed", fetch_running_balance: "fetchRunningBalance", office_id: "officeId", gl_account_id: "glAccountId", manual_entries_only: "manualEntriesOnly", from_date: "fromDate", to_date: "toDate", submitted_on_date_from: "submittedOnDateFrom", submitted_on_date_to: "submittedOnDateTo", transaction_id: "transactionId", entity_type: "entityType", order_by: "orderBy", sort_order: "sortOrder", date_format: "dateFormat", loan_id: "loanId", savings_id: "savingsId", running_balance: "runningBalance", transaction_details: "transactionDetails" }.freeze

    class GLAccounts < Resource
      def list(**query) = call(:retrieve_all_accounts, query: mapped_keys(query, Accounting::QUERY_FIELDS))
      def create(**attributes)
        validate_contract(Contracts::PhaseOne::GLAccountCreate, attributes)
        call(:create_gl_account, body: mapped_keys(attributes, Accounting::ACCOUNT_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def retrieve(account_id) = safe_call { call(:retreive_account, path: { glAccountId: id!(account_id, "gl_account_id") }) }
      def update(account_id, **attributes) = safe_call { call(:update_gl_account, path: { glAccountId: id!(account_id, "gl_account_id") }, body: mapped_keys(attributes, Accounting::ACCOUNT_FIELDS), idempotent: false) }
      def delete(account_id) = safe_call { call(:delete_gl_account, path: { glAccountId: id!(account_id, "gl_account_id") }, idempotent: false) }
      def template = call(:retrieve_new_account_details)
    end

    class Rules < Resource
      def list = call(:retrieve_all_accounting_rules)
      def create(**attributes)
        validate_contract(Contracts::PhaseOne::AccountingRuleCreate, attributes)
        call(:create_accounting_rule, body: mapped_keys(attributes, Accounting::RULE_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def retrieve(rule_id) = safe_call { call(:retrieve_one_accounting_rule, path: { accountingRuleId: id!(rule_id, "accounting_rule_id") }) }
      def update(rule_id, **attributes) = safe_call { call(:update_accounting_rule, path: { accountingRuleId: id!(rule_id, "accounting_rule_id") }, body: mapped_keys(attributes, Accounting::RULE_FIELDS), idempotent: false) }
      def delete(rule_id) = safe_call { call(:delete_accounting_rule, path: { accountingRuleId: id!(rule_id, "accounting_rule_id") }, idempotent: false) }
      def template = call(:retrieve_template_accounting_rule)
    end

    class Closures < Resource
      def list(office_id: nil) = call(:retrieve_all_gl_closures, query: { "officeId" => office_id }.compact)
      def create(**attributes)
        validate_contract(Contracts::PhaseOne::GLClosureCreate, attributes)
        call(:create_gl_closure, body: mapped_keys(attributes, Accounting::CLOSURE_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def retrieve(closure_id) = safe_call { call(:retrieve_one_gl_closure, path: { glClosureId: id!(closure_id, "gl_closure_id") }) }
      def update(closure_id, **attributes) = safe_call { call(:update_gl_closure, path: { glClosureId: id!(closure_id, "gl_closure_id") }, body: mapped_keys(attributes, Accounting::CLOSURE_FIELDS), idempotent: false) }
      def delete(closure_id) = safe_call { call(:delete_gl_closure, path: { glClosureId: id!(closure_id, "gl_closure_id") }, idempotent: false) }
    end

    class JournalEntries < Resource
      def list(**query) = call(:retrieve_all_journal_entries, query: mapped_keys(query, Accounting::QUERY_FIELDS))
      def create(command: nil, **attributes) = call(:create_gl_journal_entry, query: { "command" => command }.compact, body: mapped_keys(attributes, Accounting::JOURNAL_FIELDS), idempotent: false)
      def retrieve(journal_entry_id) = safe_call { call(:retrieve_journal_entry_by_id, path: { journalEntryId: id!(journal_entry_id, "journal_entry_id") }) }
      def reverse(transaction_id, command: nil, office_id: nil) = safe_call { call(:create_reversal_journal_entry, path: { transactionId: transaction_id.to_s }, query: { "command" => command }.compact, body: { "officeId" => office_id }.compact, idempotent: false) }
      def opening_balance = call(:retrieve_opening_balance)
      def provisioning = call(:retrieve_journal_entries)
    end

    class Accruals < Resource
      def run(till_date: nil, date_format: nil, locale: nil) = call(:execute_periodic_accrual_accounting, body: { "tillDate" => till_date, "dateFormat" => date_format, "locale" => locale }.compact, idempotent: false)
    end

    class FinancialActivityMappings < Resource
      def list = call(:retrieve_all)
      def create(**attributes)
        validate_contract(Contracts::PhaseOne::FinancialActivityMappingCreate, attributes)
        call(:create_gl_account_mapping_financial_activity_account, body: mapped_keys(attributes, Accounting::MAPPING_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def retrieve(mapping_id) = safe_call { call(:retreive, path: { mappingId: id!(mapping_id, "mapping_id") }) }
      def update(mapping_id, **attributes) = safe_call { call(:update_gl_account_mapping_financial_activity_account, path: { mappingId: id!(mapping_id, "mapping_id") }, body: mapped_keys(attributes, Accounting::MAPPING_FIELDS), idempotent: false) }
      def delete(mapping_id) = safe_call { call(:delete_gl_account_mapping_financial_activity_account, path: { mappingId: id!(mapping_id, "mapping_id") }, idempotent: false) }
    end

    attr_reader :gl_accounts, :rules, :closures, :journal_entries, :accruals, :financial_activity_mappings
    alias general_ledger_accounts gl_accounts
    def initialize(client)
      super
      @gl_accounts = GLAccounts.new(client)
      @rules = Rules.new(client)
      @closures = Closures.new(client)
      @journal_entries = JournalEntries.new(client)
      @accruals = Accruals.new(client)
      @financial_activity_mappings = FinancialActivityMappings.new(client)
    end

    private
    def validate_contract(contract, attributes)
      result = contract.new.call(attributes)
      raise ValidationError, result.errors.to_h.inspect unless result.success?
    end
  end
end
