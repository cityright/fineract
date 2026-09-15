# frozen_string_literal: true

module Fineract
  class Loans < Resource
    LOAN_FIELDS = {
      product_id: "productId", client_id: "clientId", group_id: "groupId", principal: "principal",
      submitted_on_date: "submittedOnDate", expected_disbursement_date: "expectedDisbursementDate",
      approved_on_date: "approvedOnDate", approved_principal: "approvedPrincipal", disbursed_on_date: "disbursedOnDate",
      transaction_date: "transactionDate", transaction_amount: "transactionAmount", external_id: "externalId",
      note: "note", date_format: "dateFormat", locale: "locale", fixed_emis: "fixedEmis",
      repayment_frequency_type: "repaymentFrequencyType", repayment_every: "repaymentEvery",
      repayment_frequency_nth_day_type: "repaymentFrequencyNthDayType", repayment_frequency_day_of_week_type: "repaymentFrequencyDayOfWeekType",
      number_of_repayments: "numberOfRepayments", interest_rate_per_period: "interestRatePerPeriod",
      interest_rate_frequency_type: "interestRateFrequencyType",
      interest_type: "interestType", interest_calculated_in_period: "interestCalculatedInPeriod",
      amortization_type: "amortizationType", loan_type: "loanType", repayment_start_date: "repaymentStartDate",
      reschedule_from_date: "rescheduleFromDate", grace_on_principal_periods: "graceOnPrincipalPeriod",
      grace_on_interest_periods: "graceOnInterestPeriod", grace_on_interest_payment: "graceOnInterestPayment",
      loan_term_frequency: "loanTermFrequency", loan_term_frequency_type: "loanTermFrequencyType",
      interest_recalculation_enabled: "interestRecalculationEnabled", recalculation_compounding_method: "recalculationCompoundingMethod",
      recalculation_rest_frequency_type: "recalculationRestFrequencyType", recalculation_rest_frequency_interval: "recalculationRestFrequencyInterval",
      recalculation_rest_frequency_date: "recalculationRestFrequencyDate", allow_partial_period_interest_calculation: "allowPartialPeriodInterestCalculation",
      repayment_frequency_day_of_week: "repaymentFrequencyDayOfWeek", repayment_frequency_nth_day: "repaymentFrequencyNthDay",
      payment_type_id: "paymentTypeId", submitted_by_user_id: "submittedByUserId", reason: "reason", amount: "amount"
    }.freeze
    TRANSACTION_FIELDS = LOAN_FIELDS.merge(
      principal_amount: "principalAmount", interest_amount: "interestAmount", fee_charges_amount: "feeChargesAmount",
      penalty_charges_amount: "penaltyChargesAmount", transaction_id: "transactionId", payment_type_id: "paymentTypeId",
      external_transaction_id: "externalTransactionId", unrecognized_income_portion: "unrecognizedIncomePortion"
    ).freeze
    CHARGE_FIELDS = {
      charge_id: "chargeId", amount: "amount", due_date: "dueDate", amount_paid: "amountPaid",
      amount_waived: "amountWaived", amount_outstanding: "amountOutstanding", charge_time_type: "chargeTimeType",
      charge_calculation_type: "chargeCalculationType", penalty: "penalty", currency_code: "currencyCode",
      fee_on_disbursement: "feeOnDisbursement", fee_on_loan_reschedule: "feeOnLoanReschedule",
      fee_on_repayment: "feeOnRepayment", waive_at_disbursement: "waiveAtDisbursement", note: "note",
      transaction_date: "transactionDate", date_format: "dateFormat", locale: "locale"
    }.freeze

    class Schedules < Resource
      def command(loan_id, command:, **attributes) = safe_call { call(:handle_commands_loan_schedule, path: { loanId: id!(loan_id, "loan_id") }, query: { "command" => command }, body: mapped_keys(attributes, Loans::LOAN_FIELDS), idempotent: false) }
      alias generate command
      alias reschedule command
    end

    class Transactions < Resource
      def list(loan_id) = safe_call { call(:retrieve_all_loan_transactions, path: { loanId: id!(loan_id, "loan_id") }) }
      def create(loan_id, command:, **attributes) = safe_call { call(:handle_commands_loan_transaction, path: { loanId: id!(loan_id, "loan_id") }, query: { "command" => command }, body: mapped_keys(attributes, Loans::TRANSACTION_FIELDS), idempotent: false) }
      def disburse(loan_id, **attributes) = create(loan_id, command: "disburse", **attributes)
      def repay(loan_id, **attributes) = create(loan_id, command: "repayment", **attributes)
      def refund(loan_id, **attributes) = create(loan_id, command: "refund", **attributes)
      def foreclosure(loan_id, **attributes) = create(loan_id, command: "foreclosure", **attributes)
      def write_off(loan_id, **attributes) = create(loan_id, command: "writeoff", **attributes)
      def recover(loan_id, **attributes) = create(loan_id, command: "recovery", **attributes)
      def retrieve(loan_id, transaction_id) = safe_call { call(:retrieve_one_loan_transaction, path: { loanId: id!(loan_id, "loan_id"), transactionId: id!(transaction_id, "transaction_id") }) }
      def adjust(loan_id, transaction_id, **attributes) = safe_call { call(:adjust_loan_transaction, path: { loanId: id!(loan_id, "loan_id"), transactionId: id!(transaction_id, "transaction_id") }, body: mapped_keys(attributes, TRANSACTION_FIELDS), idempotent: false) }
      def undo_waive_charge(loan_id, transaction_id, **attributes) = safe_call { call(:undo_waive_charge_loan_transaction, path: { loanId: id!(loan_id, "loan_id"), transactionId: id!(transaction_id, "transaction_id") }, body: mapped_keys(attributes, TRANSACTION_FIELDS), idempotent: false) }
      def re_age_preview(loan_id) = safe_call { call(:preview_re_age_loan_schedule, path: { loanId: id!(loan_id, "loan_id") }) }
      def re_amortize_preview(loan_id) = safe_call { call(:preview_re_amortize_loan_schedule, path: { loanId: id!(loan_id, "loan_id") }) }
    end

    class Charges < Resource
      def list(loan_id) = safe_call { call(:retrieve_all_loan_charges, path: { loanId: id!(loan_id, "loan_id") }) }
      def create(loan_id, command: nil, **attributes) = safe_call { call(:create_or_pay_loan_charge, path: { loanId: id!(loan_id, "loan_id") }, query: { "command" => command }.compact, body: mapped_keys(attributes, Loans::CHARGE_FIELDS), idempotent: false) }
      alias pay create
      def retrieve(loan_id, charge_id) = safe_call { call(:retrieve_one_loan_charge, path: { loanId: id!(loan_id, "loan_id"), loanChargeId: id!(charge_id, "charge_id") }) }
      def update(loan_id, charge_id, **attributes) = safe_call { call(:update_loan_charge, path: { loanId: id!(loan_id, "loan_id"), loanChargeId: id!(charge_id, "charge_id") }, body: mapped_keys(attributes, Loans::CHARGE_FIELDS), idempotent: false) }
      def delete(loan_id, charge_id) = safe_call { call(:delete_loan_charge, path: { loanId: id!(loan_id, "loan_id"), loanChargeId: id!(charge_id, "charge_id") }, idempotent: false) }
      def template(loan_id) = safe_call { call(:retrieve_template_loan_charge, path: { loanId: id!(loan_id, "loan_id") }) }
    end

    class Disbursements < Resource
      def update(loan_id, **attributes) = safe_call { call(:add_and_delete_disbursement_detail, path: { loanId: id!(loan_id, "loan_id") }, body: mapped_keys(attributes, Loans::LOAN_FIELDS), idempotent: false) }
      def retrieve(loan_id, disbursement_id) = safe_call { call(:retrive_detail, path: { loanId: id!(loan_id, "loan_id"), disbursementId: id!(disbursement_id, "disbursement_id") }) }
      def update_date(loan_id, disbursement_id, date:) = safe_call { call(:update_disbursement_date, path: { loanId: id!(loan_id, "loan_id"), disbursementId: id!(disbursement_id, "disbursement_id") }, body: date.to_s, request_type: "text", idempotent: false) }
    end

    class Delinquency < Resource
      def list(loan_id) = safe_call { call(:retrieve_delinquency_actions_loan, path: { loanId: id!(loan_id, "loan_id") }) }
      def create(loan_id, **attributes) = safe_call { call(:create_delinquency_action_loan, path: { loanId: id!(loan_id, "loan_id") }, body: mapped_keys(attributes), idempotent: false) }
      def tags(loan_id) = safe_call { call(:retrieve_delinquency_tag_history_loan, path: { loanId: id!(loan_id, "loan_id") }) }
    end

    attr_reader :schedules, :transactions, :charges, :disbursements, :delinquency, :collaterals, :guarantors, :post_dated_checks

    def list(**query) = call(:retrieve_all_loans, query: mapped_keys(query, client_id: "clientId", office_id: "officeId", product_id: "productId", loan_status: "loanStatus", external_id: "externalId", offset: "offset", limit: "limit", order_by: "orderBy", sort_order: "sortOrder"))
    def create(command: nil, **attributes)
      validate_contract(Contracts::PhaseOne::LoanApplicationCreate, attributes)
      call(:calculate_or_submit_loan_application, query: { "command" => command }.compact, body: mapped_keys(attributes, LOAN_FIELDS), idempotent: false)
    rescue ValidationError => e then Failure.new(e)
    end
    def submit(**attributes) = create(command: "submit", **attributes)
    def calculate(**attributes) = create(command: "calculate", **attributes)
    def template(**query) = call(:retrieve_template_loan, query: mapped_keys(query, client_id: "clientId", group_id: "groupId", product_id: "productId", template_type: "templateType", staff_in_selected_office_only: "staffInSelectedOfficeOnly", active_only: "activeOnly"))
    def approval_template(loan_id, template_type: nil) = safe_call { call(:retrieve_approval_template, path: { loanId: id!(loan_id, "loan_id") }, query: { "templateType" => template_type }.compact) }
    def retrieve(loan_id) = safe_call { call(:retrieve_one_loan, path: { loanId: id!(loan_id, "loan_id") }) }
    def update(loan_id, **attributes) = safe_call { call(:update_loan_application, path: { loanId: id!(loan_id, "loan_id") }, body: mapped_keys(attributes, LOAN_FIELDS), idempotent: false) }
    def service(loan_id, command:, **attributes) = safe_call { call(:handle_commands_loan, path: { loanId: id!(loan_id, "loan_id") }, query: { "command" => command }, body: mapped_keys(attributes, LOAN_FIELDS), idempotent: false) }
    def approve(loan_id, **attributes) = service(loan_id, command: "approve", **attributes)
    def reject(loan_id, **attributes) = service(loan_id, command: "reject", **attributes)
    def withdraw(loan_id, **attributes) = service(loan_id, command: "withdraw", **attributes)
    def disburse(loan_id, **attributes) = transactions.disburse(loan_id, **attributes)
    def reschedule(loan_id, **attributes) = service(loan_id, command: "reschedule", **attributes)
    def vary_term(loan_id, **attributes) = service(loan_id, command: "modifyLoanApplication", **attributes)
    def foreclosure(loan_id, **attributes) = transactions.foreclosure(loan_id, **attributes)
    def write_off(loan_id, **attributes) = transactions.write_off(loan_id, **attributes)
    def recover(loan_id, **attributes) = transactions.recover(loan_id, **attributes)
    def amortization_allocation_rules(loan_id) = safe_call { call(:get_advanced_payment_allocation_rules_of_loan, path: { loanId: id!(loan_id, "loan_id") }) }
    def initialize(client)
      super
      @schedules = Schedules.new(client)
      @transactions = Transactions.new(client)
      @charges = Charges.new(client)
      @disbursements = Disbursements.new(client)
      @delinquency = Delinquency.new(client)
      @collaterals = LoanCollaterals.new(client)
      @guarantors = LoanGuarantors.new(client)
      @post_dated_checks = PostDatedChecks.new(client)
    end
  end
end
