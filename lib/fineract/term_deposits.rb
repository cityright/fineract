# frozen_string_literal: true

# rubocop:disable all
module Fineract
  class TermDeposits < Resource
    class Products < Resource
      def initialize(client, prefix) = super(client).tap { @prefix = prefix }
      def list = call("retrieveAll#{@prefix}DepositProducts")
      def create(**attributes)
        Contracts::TermDeposits.product_create(attributes)
        call("create#{@prefix}DepositProduct", body: wire_keys(attributes), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def template = call("retrieveTemplate#{@prefix}DepositProduct")
      def retrieve(id) = safe_call { call("retrieveOne#{@prefix}DepositProduct", path: { productId: id!(id, "product_id") }) }
      def update(id, **attributes) = safe_call { call("update#{@prefix}DepositProduct", path: { productId: id!(id, "product_id") }, body: wire_keys(attributes), idempotent: false) }
      def delete(id) = safe_call { call("delete#{@prefix}DepositProduct", path: { productId: id!(id, "product_id") }, idempotent: false) }
    end

    class Accounts < Resource
      def initialize(client, prefix) = super(client).tap { @prefix = prefix }
      def list(**query) = call("retrieveAll#{@prefix}DepositAccounts", query: wire_keys(query))
      def create(**attributes)
        Contracts::TermDeposits.account_create(attributes)
        operation = @prefix == "Fixed" ? :create_fixed_deposit_account : :submit_application_recurring_deposit_account
        call(operation, body: wire_keys(attributes), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def interest(**query)
        return Failure.new(UnknownOperationError.new("interest calculation is only available for fixed deposits")) unless @prefix == "Fixed"

        call(:calculate_fixed_deposit_interest, query: wire_keys(query))
      end
      def template(**query) = call("retrieveTemplate#{@prefix}DepositAccount", query: wire_keys(query))
      def download_template(**query) = call("get#{@prefix}DepositTemplate", query: wire_keys(query))
      def upload_template(uploaded_input_stream:, locale: nil, date_format: nil)
        call("post#{@prefix}DepositTemplate", body: wire_keys(uploaded_input_stream: uploaded_input_stream, locale: locale, date_format: date_format).compact, request_type: "multipart/form-data", idempotent: false)
      end
      def retrieve(id, **query) = safe_call { call("retrieveOne#{@prefix}DepositAccount", path: { accountId: id!(id, "account_id") }, query: wire_keys(query)) }
      def update(id, **attributes) = safe_call { call("update#{@prefix}DepositAccount", path: { accountId: id!(id, "account_id") }, body: wire_keys(attributes), idempotent: false) }
      def delete(id) = safe_call { call("delete#{@prefix}DepositAccount", path: { accountId: id!(id, "account_id") }, idempotent: false) }
      def command(id, command:, **attributes) = safe_call { call("handleCommands#{@prefix}DepositAccount", path: { accountId: id!(id, "account_id") }, query: { "command" => command }, body: wire_keys(attributes), idempotent: false) }
      def closure_template(id, command: nil)
        return Failure.new(UnknownOperationError.new("closure templates are only available for recurring deposits")) unless @prefix == "Recurring"

        safe_call { call(:account_closure_template_recurring_deposit_account, path: { accountId: id!(id, "account_id") }, query: { "command" => command }.compact) }
      end
    end

    class Transactions < Resource
      def initialize(client, prefix) = super(client).tap { @prefix = prefix }
      def list(id)
        return Failure.new(UnknownOperationError.new("recurring deposit transaction listing is not in the pinned contract")) unless @prefix == "Fixed"
        safe_call { call(:retrieve_all_fixed_deposit_account_transactions, path: { fixedDepositAccountId: id!(id, "account_id") }) }
      end
      def create(id, command: nil, **attributes)
        Contracts::TermDeposits.transaction_create(attributes)
        operation = @prefix == "Fixed" ? :transaction : :transaction_recurring_deposit_account_transaction
        call(operation, path: { (@prefix == "Fixed" ? :fixedDepositAccountId : :recurringDepositAccountId) => id!(id, "account_id") }, query: { "command" => command }.compact, body: wire_keys(attributes), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def template(id) = safe_call { call("retrieveTemplate#{@prefix}DepositAccountTransaction", path: { (@prefix == "Fixed" ? :fixedDepositAccountId : :recurringDepositAccountId) => id!(id, "account_id") }) }
      def retrieve(id, transaction_id) = safe_call { call("retrieveOne#{@prefix}DepositAccountTransaction", path: { (@prefix == "Fixed" ? :fixedDepositAccountId : :recurringDepositAccountId) => id!(id, "account_id"), transactionId: id!(transaction_id, "transaction_id") }) }
      def command(id, transaction_id, command:, **attributes) = safe_call { call("handleCommands#{@prefix}DepositAccountTransaction", path: { (@prefix == "Fixed" ? :fixedDepositAccountId : :recurringDepositAccountId) => id!(id, "account_id"), transactionId: id!(transaction_id, "transaction_id") }, query: { "command" => command }, body: wire_keys(attributes), idempotent: false) }
      def download_template(**query) = call("get#{@prefix}DepositTransactionTemplate", query: wire_keys(query))
      def upload_template(uploaded_input_stream:, locale: nil, date_format: nil)
        operation = @prefix == "Fixed" ? :post_fixed_deposit_transaction_template : :post_recurring_deposit_transactions_template
        call(operation, body: wire_keys(uploaded_input_stream: uploaded_input_stream, locale: locale, date_format: date_format).compact, request_type: "multipart/form-data", idempotent: false)
      end
    end

    attr_reader :products, :accounts, :transactions
    def initialize(client, prefix)
      super(client)
      @products = Products.new(client, prefix)
      @accounts = Accounts.new(client, prefix)
      @transactions = Transactions.new(client, prefix)
    end
  end
end

# rubocop:enable all
