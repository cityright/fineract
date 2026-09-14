# frozen_string_literal: true

module Fineract
  class Shares < Resource
    PRODUCT_FIELDS = {
      accounting_rule: "accountingRule", allow_dividend_calculation_for_inactive_clients: "allowDividendCalculationForInactiveClients",
      charges_selected: "chargesSelected", currency_code: "currencyCode", description: "description",
      digits_after_decimal: "digitsAfterDecimal", in_multiples_of: "inMultiplesOf", locale: "locale",
      lockin_period_frequency: "lockinPeriodFrequency", lockin_period_frequency_type: "lockinPeriodFrequencyType",
      market_price_periods: "marketPricePeriods", maximum_shares: "maximumShares", minimum_shares: "minimumShares",
      minimum_active_period_for_dividends: "minimumActivePeriodForDividends", minimumactiveperiod_frequency_type: "minimumactiveperiodFrequencyType",
      name: "name", nominal_shares: "nominalShares", shares_issued: "sharesIssued", short_name: "shortName",
      total_shares: "totalShares", unit_price: "unitPrice"
    }.freeze
    ACCOUNT_FIELDS = {
      allow_dividend_calculation_for_inactive_clients: "allowDividendCalculationForInactiveClients", application_date: "applicationDate",
      approved_date: "approvedDate", charges: "charges", client_id: "clientId", currency_code: "currencyCode",
      date_format: "dateFormat", digits_after_decimal: "digitsAfterDecimal", external_id: "externalId",
      in_multiples_of: "inMultiplesOf", locale: "locale", lockin_period_frequency: "lockinPeriodFrequency",
      lockin_period_frequency_type: "lockinPeriodFrequencyType", minimum_active_period: "minimumActivePeriod",
      minimum_active_period_frequency_type: "minimumActivePeriodFrequencyType", number_of_shares: "numberOfShares",
      product_id: "productId", purchased_date: "purchasedDate", requested_shares: "requestedShares", savings_account_id: "savingsAccountId",
      submitted_date: "submittedDate", unit_price: "unitPrice"
    }.freeze
    TRANSFER_FIELDS = {
      date_format: "dateFormat", from_account_id: "fromAccountId", from_account_type: "fromAccountType", from_client_id: "fromClientId",
      from_office_id: "fromOfficeId", locale: "locale", to_account_id: "toAccountId", to_account_type: "toAccountType",
      to_client_id: "toClientId", to_office_id: "toOfficeId", transfer_amount: "transferAmount", transfer_date: "transferDate",
      transfer_description: "transferDescription"
    }.freeze

    class Products < Resource
      def list(type: "shares", offset: nil, limit: nil) = call(:retrieve_all_share_products, path: { type: type }, query: { "offset" => offset, "limit" => limit }.compact)
      def create(type: "shares", **attributes)
        validate_contract(Contracts::PhaseOne::ShareProductCreate, attributes)
        call(:create_share_product, path: { type: type }, body: mapped_keys(attributes, Shares::PRODUCT_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def template(type: "shares") = call(:retrieve_template_share_product, path: { type: type })
      def retrieve(product_id, type: "shares") = safe_call { call(:retrieve_one_share_product, path: { type: type, productId: id!(product_id, "product_id") }) }
      def update(product_id, type: "shares", **attributes) = safe_call { call(:update_share_product, path: { type: type, productId: id!(product_id, "product_id") }, body: mapped_keys(attributes, Shares::PRODUCT_FIELDS), idempotent: false) }
      def command(product_id, command:, type: "shares", **attributes) = safe_call { call(:handle_commands_share_product, path: { type: type, productId: id!(product_id, "product_id") }, query: { "command" => command }, body: mapped_keys(attributes, Shares::PRODUCT_FIELDS), idempotent: false) }
    end

    class Accounts < Resource
      def list(type: "shares", offset: nil, limit: nil) = call(:retrieve_all_share_accounts, path: { type: type }, query: { "offset" => offset, "limit" => limit }.compact)
      def create(type: "shares", **attributes)
        validate_contract(Contracts::PhaseOne::ShareAccountCreate, attributes)
        call(:create_share_account, path: { type: type }, body: mapped_keys(attributes, Shares::ACCOUNT_FIELDS), idempotent: false)
      rescue ValidationError => e then Failure.new(e)
      end
      def template(type: "shares", client_id: nil, product_id: nil) = call(:retrieve_template_share_account, path: { type: type }, query: { "clientId" => client_id, "productId" => product_id }.compact)
      def retrieve(account_id, type: "shares") = safe_call { call(:retrieve_one_share_account, path: { type: type, accountId: id!(account_id, "account_id") }) }
      def update(account_id, type: "shares", **attributes) = safe_call { call(:update_share_account, path: { type: type, accountId: id!(account_id, "account_id") }, body: mapped_keys(attributes, Shares::ACCOUNT_FIELDS), idempotent: false) }
      def command(account_id, command:, type: "shares", **attributes) = safe_call { call(:handle_commands_share_account, path: { type: type, accountId: id!(account_id, "account_id") }, query: { "command" => command }, body: mapped_keys(attributes, Shares::ACCOUNT_FIELDS), idempotent: false) }
      def approve(account_id, **attributes) = command(account_id, command: "approve", **attributes)
      def activate(account_id, **attributes) = command(account_id, command: "activate", **attributes)
      def close(account_id, **attributes) = command(account_id, command: "close", **attributes)
    end

    class Dividends < Resource
      def list(product_id, **query) = call(:retrieve_all_share_dividends, path: { productId: id!(product_id, "product_id") }, query: mapped_keys(query, order_by: "orderBy", sort_order: "sortOrder"))
      def create(product_id, dividend_date:) = call(:create_share_dividend, path: { productId: id!(product_id, "product_id") }, body: dividend_date.to_s, request_type: :json, idempotent: false)
      def retrieve(product_id, dividend_id, **query) = safe_call { call(:retrieve_one_share_dividend, path: { productId: id!(product_id, "product_id"), dividendId: id!(dividend_id, "dividend_id") }, query: mapped_keys(query, account_no: "accountNo", order_by: "orderBy", sort_order: "sortOrder")) }
      def update(product_id, dividend_id, dividend_date:, command: nil) = safe_call { call(:update_share_dividend, path: { productId: id!(product_id, "product_id"), dividendId: id!(dividend_id, "dividend_id") }, query: { "command" => command }.compact, body: dividend_date.to_s, request_type: :json, idempotent: false) }
      def delete(product_id, dividend_id) = safe_call { call(:delete_share_dividend, path: { productId: id!(product_id, "product_id"), dividendId: id!(dividend_id, "dividend_id") }, idempotent: false) }
    end

    attr_reader :products, :accounts, :dividends
    def initialize(client)
      super
      @products, @accounts, @dividends = Products.new(client), Accounts.new(client), Dividends.new(client)
    end
  end
end
