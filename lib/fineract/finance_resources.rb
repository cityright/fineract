# frozen_string_literal: true

require "dry/validation"

module Fineract
  module Contracts
    module Finance
      class Named < Dry::Validation::Contract
        params { required(:name).filled(:string) }
      end
      class PaymentType < Dry::Validation::Contract
        params { required(:name).filled(:string); required(:is_system_defined).filled(:bool) }
      end
      class ProvisioningEntry < Dry::Validation::Contract
        params { required(:date).filled(:string) }
      end
      class TaxComponent < Dry::Validation::Contract
        params { required(:name).filled(:string); required(:percentage).filled }
      end
      class TaxGroup < Dry::Validation::Contract
        params { required(:name).filled(:string); required(:tax_components).filled(:array) }
      end
      class InterestRateChartSlab < Dry::Validation::Contract
        params { required(:currency_code).filled(:string); required(:from_period).filled(:integer); required(:to_period).filled(:integer); required(:annual_interest_rate).filled }
      end
    end
  end

  class FinanceResource < Resource
    def initialize(client, collection, singular)
      super(client); @collection = collection; @singular = singular
    end
    def list(**query) = call("retrieveAll#{@collection}", query: mapped_keys(query))
    def retrieve(id) = safe_call { call("retrieveOne#{@singular}", path: { id_param => id!(id, "id") }) }
    def create(**attributes) = call("create#{@singular}", body: mapped_keys(attributes), idempotent: false)
    def update(id, **attributes) = safe_call { call("update#{@singular}", path: { id_param => id!(id, "id") }, body: mapped_keys(attributes), idempotent: false) }
    def delete(id) = safe_call { call("delete#{@singular}", path: { id_param => id!(id, "id") }, idempotent: false) }
    private
    def id_param = { "PaymentType" => :paymentTypeId, "FloatingRate" => :floatingRateId, "InterestRateChart" => :chartId, "TaxComponent" => :taxComponentId, "TaxGroup" => :taxGroupId }.fetch(@singular, :id)
  end

  class Provisioning < Resource
    CRITERIA_FIELDS = { criteria_name: "criteriaName", loan_products: "loanProducts", provisioningcriteria: "provisioningcriteria" }.freeze
    ENTRY_FIELDS = { create_journal_entries: "createjournalentries", date: "date", date_format: "dateFormat", locale: "locale" }.freeze
    def initialize(client); super; @criteria = Criteria.new(client); @entries = Entries.new(client) end
    attr_reader :criteria, :entries
    class Criteria < Resource
      def list(**query) = call(:retrieve_all_provisioning_criteria, query: mapped_keys(query))
      def template = call(:retrieve_template_1)
      def create(**attributes) = call(:create_provisioning_criteria, body: mapped_keys(attributes, Provisioning::CRITERIA_FIELDS), idempotent: false)
      def retrieve(id) = safe_call { call(:retrieve_one_provisioning_criteria, path: { criteriaId: id!(id, "criteria_id") }) }
      def update(id, **attributes) = safe_call { call(:update_provisioning_criteria, path: { criteriaId: id!(id, "criteria_id") }, body: mapped_keys(attributes, Provisioning::CRITERIA_FIELDS), idempotent: false) }
      def delete(id) = safe_call { call(:delete_provisioning_criteria, path: { criteriaId: id!(id, "criteria_id") }, idempotent: false) }
    end
    class Entries < Resource
      def list(**query) = call(:retrieve_all_provisioning_entries, query: mapped_keys(query))
      def loan_products(**query) = call(:retrieve_provisioning_entries_loan_products, query: mapped_keys(query))
      def create(**attributes)
        validate_contract(Contracts::Finance::ProvisioningEntry, attributes)
        call(:create_provisioning_entries, body: mapped_keys(attributes, Provisioning::ENTRY_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def retrieve(id) = call(:retrieve_one_provisioning_entry, path: { entryId: id!(id, "entry_id") })
      def command(id, command:) = call(:modify_provisioning_entry, path: { entryId: id!(id, "entry_id") }, body: { "command" => command }, idempotent: false)
    end
  end

  class Taxes < Resource
    COMPONENT_FIELDS = { credit_account_id: "creditAccountId", credit_account_type: "creditAccountType", debit_account_id: "debitAccountId", debit_account_type: "debitAccountType", date_format: "dateFormat", locale: "locale", name: "name", percentage: "percentage", start_date: "startDate" }.freeze
    GROUP_FIELDS = { date_format: "dateFormat", locale: "locale", name: "name", tax_components: "taxComponents" }.freeze
    def initialize(client); super; @components = Components.new(client); @groups = Groups.new(client) end
    attr_reader :components, :groups
    class Components < FinanceResource
      def initialize(client) = super(client, "TaxComponents", "TaxComponent")
      def template = call(:retrieve_template_tax_component)
      def create(**a) = call(:create_tax_component, body: mapped_keys(a, Taxes::COMPONENT_FIELDS), idempotent: false)
      def update(id, **a) = super(id, **a)
    end
    class Groups < FinanceResource
      def initialize(client) = super(client, "TaxGroups", "TaxGroup")
      def template = call(:retrieve_template_tax_group)
      def create(**a) = call(:create_tax_group, body: mapped_keys(a, Taxes::GROUP_FIELDS), idempotent: false)
    end
  end

  class PaymentTypes < FinanceResource
    FIELDS = { code_name: "codeName", description: "description", is_cash_payment: "isCashPayment", is_system_defined: "isSystemDefined", name: "name", position: "position" }.freeze
    def initialize(client) = super(client, "PaymentTypes", "PaymentType")
    def list(**query) = call(:get_all_payment_types, query: mapped_keys(query))
    def create(**a)
      validate_contract(Contracts::Finance::PaymentType, a)
      super(**a)
    rescue ValidationError => e then Failure.new(e)
    end
    def update(id, **a) = call(:update_payment_type, path: { paymentTypeId: id!(id, "payment_type_id") }, body: mapped_keys(a, FIELDS), idempotent: false)
  end

  class Rates < FinanceResource
    FIELDS = { name: "name", percentage: "percentage", is_active: "isActive" }.freeze
    def initialize(client) = super(client, "Rates", "Rate")
    def create(**a) = call(:create_rate, body: mapped_keys(a, FIELDS), idempotent: false)
    def retrieve(id) = call(:retrieve_one_rate, path: { rateId: id!(id, "rate_id") })
    def update(id, **a) = call(:update_rate, path: { rateId: id!(id, "rate_id") }, body: mapped_keys(a, FIELDS), idempotent: false)
  end

  class FloatingRates < FinanceResource
    FIELDS = { is_active: "isActive", is_base_lending_rate: "isBaseLendingRate", name: "name", rate_periods: "ratePeriods" }.freeze
    def initialize(client) = super(client, "FloatingRates", "FloatingRate")
    def create(**a) = call(:create_floating_rate, body: mapped_keys(a, FIELDS), idempotent: false)
    def update(id, **a) = call(:update_floating_rate, path: { floatingRateId: id!(id, "floating_rate_id") }, body: mapped_keys(a, FIELDS), idempotent: false)
  end

  class InterestRateCharts < FinanceResource
    FIELDS = { date_format: "dateFormat", description: "description", from_date: "fromDate", locale: "locale", name: "name", type: "type" }.freeze
    def initialize(client); super(client, "InterestRateCharts", "InterestRateChart"); @slabs = Slabs.new(client) end
    attr_reader :slabs
    def template = call(:retrieve_template_interest_rate_chart)
    def create(**a) = call(:create_interest_rate_chart, body: mapped_keys(a, FIELDS), idempotent: false)
    def update(id, **a) = call(:update_interest_rate_chart, path: { chartId: id!(id, "chart_id") }, body: mapped_keys(a), idempotent: false)
    class Slabs < FinanceResource
      FIELDS = { amount_range_from: "amountRangeFrom", amount_range_to: "amountRangeTo", annual_interest_rate: "annualInterestRate", chart_slab_id: "chartSlabId", currency_code: "currencyCode", description: "description", from_period: "fromPeriod", incentives: "incentives", locale: "locale", period_type: "periodType", to_period: "toPeriod" }.freeze
      def initialize(client) = super(client, "InterestRateChartSlabs", "InterestRateChartSlab")
      def list(chart_id, **q) = call(:retrieve_all_interest_rate_chart_slabs, path: { chartId: id!(chart_id, "chart_id") }, query: mapped_keys(q))
      def template(chart_id) = call(:retrieve_template_interest_rate_chart_slab, path: { chartId: id!(chart_id, "chart_id") })
      def create(chart_id, **a) = call(:create_interest_rate_chart_slab, path: { chartId: id!(chart_id, "chart_id") }, body: mapped_keys(a, FIELDS), idempotent: false)
      def retrieve(chart_id, slab_id) = call(:retrieve_one_interest_rate_chart_slab, path: { chartId: id!(chart_id, "chart_id"), chartSlabId: id!(slab_id, "chart_slab_id") })
      def update(chart_id, slab_id, **a) = call(:update_interest_rate_chart_slab, path: { chartId: id!(chart_id, "chart_id"), chartSlabId: id!(slab_id, "chart_slab_id") }, body: mapped_keys(a, FIELDS), idempotent: false)
      def delete(chart_id, slab_id) = call(:delete_interest_rate_chart_slab, path: { chartId: id!(chart_id, "chart_id"), chartSlabId: id!(slab_id, "chart_slab_id") }, idempotent: false)
    end
  end
end
