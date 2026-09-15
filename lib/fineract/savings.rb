# frozen_string_literal: true

module Fineract
  class Savings < Resource
    PRODUCT_FIELDS = {
      accounting_rule: "accountingRule", annual_nominal_interest_rate: "annualNominalInterestRate",
      currency_code: "currencyCode", digits_after_decimal: "digitsAfterDecimal", description: "description",
      interest_calculation_type: "interestCalculationType", interest_compounding_period_type: "interestCompoundingPeriodType",
      interest_posting_period_type: "interestPostingPeriodType", lock_in_period_frequency: "lockinPeriodFrequency",
      lock_in_period_frequency_type: "lockinPeriodFrequencyType", min_balance_for_interest_calculation: "minBalanceForInterestCalculation",
      name: "name", nominal_annual_interest_rate: "nominalAnnualInterestRate", short_name: "shortName",
      tax_group_id: "taxGroupId", withdrawal_fee_for_transfer: "withdrawalFeeForTransfer", charges: "charges",
      overdraft_allowance: "allowOverdraft", overdraft_limit: "overdraftLimit", enforce_min_required_balance: "enforceMinRequiredBalance"
    }.freeze
    ACCOUNT_FIELDS = {
      client_id: "clientId", product_id: "productId", field_officer_id: "fieldOfficerId", submitted_on_date: "submittedOnDate",
      activation_date: "activationDate", approved_date: "approvedDate", closed_date: "closedDate", rejected_date: "rejectedDate",
      withdrawn_on_date: "withdrawnOnDate", external_id: "externalId", account_no: "accountNo", locale: "locale",
      date_format: "dateFormat", charges: "charges", beneficiaries: "beneficiaries"
    }.freeze
    TRANSACTION_FIELDS = {
      amount: "amount", transaction_amount: "transactionAmount", transaction_date: "transactionDate", payment_type_id: "paymentTypeId",
      account_number: "accountNumber", check_number: "checkNumber", routing_code: "routingCode", receipt_number: "receiptNumber",
      note: "note", locale: "locale", date_format: "dateFormat", external_id: "externalId"
    }.freeze
    CHARGE_FIELDS = { charge_id: "chargeId", amount: "amount", due_date: "dueDate", date_format: "dateFormat", locale: "locale", external_id: "externalId" }.freeze
    STANDING_FIELDS = { from_account_id: "fromAccountId", from_account_type: "fromAccountType", to_account_id: "toAccountId", to_account_type: "toAccountType", amount: "amount", transfer_type: "transferType", execution_time: "executionTime", recurrence: "recurrence", valid_from: "validFrom", valid_to: "validTo", status: "status", client_id: "clientId", name: "name", external_id: "externalId", instruction_type: "instructionType" }.freeze

    class Products < Resource
      def list = call(:retrieve_all_savings_products)
      def template = call(:retrieve_template_savings_product)
      def create(**attributes)
        validate_contract(Contracts::Savings, attributes, :product_create)
        call(:create_savings_product, body: mapped_keys(attributes, Savings::PRODUCT_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def retrieve(id) = safe_call { call(:retrieve_one_savings_product, path: { productId: id!(id, "product_id") }) }
      def update(id, **attributes) = safe_call { call(:update_savings_product, path: { productId: id!(id, "product_id") }, body: mapped_keys(attributes, Savings::PRODUCT_FIELDS), idempotent: false) }
      def delete(id) = safe_call { call(:delete_savings_product, path: { productId: id!(id, "product_id") }, idempotent: false) }
    end

    class Accounts < Resource
      def list(**query) = call(:retrieve_all_savings_accounts, query: mapped_keys(query))
      def template = call(:retrieve_savings_account_template)
      def create(**attributes)
        validate_contract(Contracts::Savings, attributes, :account_create)
        call(:submit_savings_application, body: mapped_keys(attributes, Savings::ACCOUNT_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def retrieve(id) = safe_call { call(:retrieve_savings_account, path: { accountId: id!(id, "account_id") }) }
      def retrieve_external(external_id) = safe_call { call(:retrieve_savings_account_by_external_id, path: { externalId: external_id.to_s }) }
      def update(id, **attributes) = safe_call { call(:update_savings_account, path: { accountId: id!(id, "account_id") }, body: mapped_keys(attributes, Savings::ACCOUNT_FIELDS), idempotent: false) }
      def update_external(external_id, **attributes) = safe_call { call(:update_savings_account_by_external_id, path: { externalId: external_id.to_s }, body: mapped_keys(attributes, Savings::ACCOUNT_FIELDS), idempotent: false) }
      def delete(id) = safe_call { call(:delete_savings_account, path: { accountId: id!(id, "account_id") }, idempotent: false) }
      def command(id, command:, **attributes) = safe_call { call(:handle_commands_savings_account, path: { accountId: id!(id, "account_id") }, query: { "command" => command }, body: mapped_keys(attributes, Savings::ACCOUNT_FIELDS), idempotent: false) }
      def beneficiaries(id, **attributes) = update(id, beneficiaries: [attributes])
      %i[approve activate close reject withdraw reopen].each do |lifecycle_command|
        define_method(lifecycle_command) { |account_id, **attributes| command(account_id, command: lifecycle_command.to_s, **attributes) }
      end
    end

    class Transactions < Resource
      def list(account_id, **query) = call(:search_savings_account_transactions, path: { savingsId: id!(account_id, "account_id") }, query: mapped_keys(query))
      alias search list
      def template(account_id) = safe_call { call(:retrieve_template_savings_account_transaction, path: { savingsId: id!(account_id, "account_id") }) }
      def create(account_id, command: nil, **attributes)
        validate_contract(Contracts::Savings, attributes, :transaction_create)
        call(:create_savings_account_transaction, path: { savingsId: id!(account_id, "account_id") }, query: { "command" => command }.compact, body: mapped_keys(attributes, Savings::TRANSACTION_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def retrieve(account_id, transaction_id) = safe_call { call(:retrieve_one_savings_account_transaction, path: { savingsId: id!(account_id, "account_id"), transactionId: id!(transaction_id, "transaction_id") }) }
      def adjust(account_id, transaction_id, **attributes) = safe_call { call(:adjust_savings_account_transaction, path: { savingsId: id!(account_id, "account_id"), transactionId: id!(transaction_id, "transaction_id") }, body: mapped_keys(attributes, Savings::TRANSACTION_FIELDS), idempotent: false) }
      def advanced(account_id, **query) = call(:advanced_query_savings_account_transactions, path: { savingsId: id!(account_id, "account_id") }, body: mapped_keys(query, Savings::TRANSACTION_FIELDS), idempotent: false)
      alias query advanced
    end

    class Charges < Resource
      def list(account_id) = safe_call { call(:retrieve_all_savings_account_charges, path: { savingsAccountId: id!(account_id, "account_id") }) }
      def template(account_id) = safe_call { call(:retrieve_template_savings_account_charge, path: { savingsAccountId: id!(account_id, "account_id") }) }
      def create(account_id, command: nil, **attributes) = safe_call { call(:create_savings_account_charge, path: { savingsAccountId: id!(account_id, "account_id") }, query: { "command" => command }.compact, body: mapped_keys(attributes, Savings::CHARGE_FIELDS), idempotent: false) }
      def retrieve(account_id, charge_id) = safe_call { call(:retrieve_one_savings_account_charge, path: { savingsAccountId: id!(account_id, "account_id"), savingsAccountChargeId: id!(charge_id, "charge_id") }) }
      def update(account_id, charge_id, **attributes) = safe_call { call(:update_savings_account_charge, path: { savingsAccountId: id!(account_id, "account_id"), savingsAccountChargeId: id!(charge_id, "charge_id") }, body: mapped_keys(attributes, Savings::CHARGE_FIELDS), idempotent: false) }
      def delete(account_id, charge_id) = safe_call { call(:delete_savings_account_charge, path: { savingsAccountId: id!(account_id, "account_id"), savingsAccountChargeId: id!(charge_id, "charge_id") }, idempotent: false) }
      def command(account_id, charge_id, command:, **attributes) = safe_call { call(:handle_commands_savings_account_charge, path: { savingsAccountId: id!(account_id, "account_id"), savingsAccountChargeId: id!(charge_id, "charge_id") }, query: { "command" => command }, body: mapped_keys(attributes, Savings::CHARGE_FIELDS), idempotent: false) }
    end

    class StandingInstructions < Resource
      def list(**query) = call(:retrieve_all_standing_instructions, query: mapped_keys(query))
      def template = call(:retrieve_template_standing_instruction)
      def history(**query) = call(:retrieve_all_standing_instruction_history, query: mapped_keys(query))
      def create(**attributes) = call(:create_standing_instruction, body: mapped_keys(attributes, Savings::STANDING_FIELDS), idempotent: false)
      def retrieve(id) = safe_call { call(:retrieve_one_standing_instruction, path: { standingInstructionId: id!(id, "standing_instruction_id") }) }
      def update(id, **attributes) = safe_call { call(:update_standing_instruction, path: { standingInstructionId: id!(id, "standing_instruction_id") }, body: mapped_keys(attributes, Savings::STANDING_FIELDS), idempotent: false) }
    end

    attr_reader :products, :accounts, :transactions, :charges, :standing_instructions
    def initialize(client)
      super
      @products, @accounts, @transactions, @charges, @standing_instructions = Products.new(client), Accounts.new(client), Transactions.new(client), Charges.new(client), StandingInstructions.new(client)
    end
  end
end
