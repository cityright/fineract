# frozen_string_literal: true

module Fineract
  class LoanProducts < Resource
    PRODUCT_FIELDS = {
      name: "name", short_name: "shortName", description: "description", currency_code: "currencyCode",
      principal: "principal", min_principal: "minPrincipal", max_principal: "maxPrincipal",
      number_of_repayments: "numberOfRepayments", min_number_of_repayments: "minNumberOfRepayments",
      max_number_of_repayments: "maxNumberOfRepayments", repayment_every: "repaymentEvery",
      repayment_frequency_type: "repaymentFrequencyType", interest_rate_per_period: "interestRatePerPeriod",
      min_interest_rate_per_period: "minInterestRatePerPeriod", max_interest_rate_per_period: "maxInterestRatePerPeriod",
      interest_rate_frequency_type: "interestRateFrequencyType", amortization_type: "amortizationType",
      interest_type: "interestType", transaction_processing_strategy_code: "transactionProcessingStrategyCode",
      accounting_rule: "accountingRule", fund_id: "fundId", external_id: "externalId", active: "active",
      close_date: "closeDate", start_date: "startDate", date_format: "dateFormat", locale: "locale",
      loan_portfolio_account_id: "loanPortfolioAccountId", fund_source_account_id: "fundSourceAccountId",
      interest_on_loan_account_id: "interestOnLoanAccountId", income_from_fee_account_id: "incomeFromFeeAccountId",
      income_from_penalty_account_id: "incomeFromPenaltyAccountId", write_off_account_id: "writeOffAccountId",
      overdue_days_for_npa: "overdueDaysForNPA", grace_on_principal_payment: "graceOnPrincipalPayment",
      grace_on_interest_payment: "graceOnInterestPayment", interest_recalculation_enabled: "isInterestRecalculationEnabled",
      multi_disburse_loan: "multiDisburseLoan", allow_attribute_overrides: "allowAttributeOverrides",
      charges: "charges", credit_allocation: "creditAllocation", payment_allocation: "paymentAllocation"
    }.freeze

    class ProductMixes < Resource
      def retrieve(product_id) = safe_call { call(:retrieve_template_product_mix, path: { productId: id!(product_id, "product_id") }) }
      def create(product_id, restricted_products:)
        validate_contract(Contracts::PhaseOne::ProductMix, restricted_products: restricted_products)
        call(:create_product_mix, path: { productId: id!(product_id, "product_id") }, body: { "restrictedProducts" => restricted_products }, idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def update(product_id, restricted_products:)
        validate_contract(Contracts::PhaseOne::ProductMix, restricted_products: restricted_products)
        call(:update_product_mix, path: { productId: id!(product_id, "product_id") }, body: { "restrictedProducts" => restricted_products }, idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def delete(product_id) = safe_call { call(:delete_product_mix, path: { productId: id!(product_id, "product_id") }, idempotent: false) }
    end

    attr_reader :product_mixes
    def list = call(:retrieve_all_loan_products)
    def basic_details = call(:retrieve_all_loan_products_details)
    def create(**attributes)
      validate_contract(Contracts::PhaseOne::LoanProductCreate, attributes)
      call(:create_loan_product, body: mapped_keys(attributes, PRODUCT_FIELDS), idempotent: false)
    rescue ValidationError => e then Failure.new(e)
    end
    def retrieve(product_id) = safe_call { call(:retrieve_one_loan_product, path: { productId: id!(product_id, "product_id") }) }
    def update(product_id, **attributes) = safe_call { call(:update_loan_product, path: { productId: id!(product_id, "product_id") }, body: mapped_keys(attributes, PRODUCT_FIELDS), idempotent: false) }
    def template = call(:retrieve_template_loan_product)
    def initialize(client)
      super
      @product_mixes = ProductMixes.new(client)
    end
  end
end
