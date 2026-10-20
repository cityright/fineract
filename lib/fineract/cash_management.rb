# frozen_string_literal: true

module Fineract
  class CashManagement < Resource
    TELLER_FIELDS = { date_format: "dateFormat", description: "description", end_date: "endDate", locale: "locale",
                      name: "name", office_id: "officeId", start_date: "startDate", status: "status" }.freeze
    CASHIER_FIELDS = { date_format: "dateFormat", description: "description", end_date: "endDate",
                       is_full_day: "isFullDay", locale: "locale", staff_id: "staffId", start_date: "startDate" }.freeze
    TRANSACTION_FIELDS = { currency_code: "currencyCode", date_format: "dateFormat", locale: "locale",
                           txn_amount: "txnAmount", txn_date: "txnDate", txn_note: "txnNote" }.freeze

    class Cashiers < Resource
      def list(**query) = call(:retrieve_all_cashiers, query: mapped_keys(query))
      alias all list
    end

    class CashierJournals < Resource
      def list(**query) = call(:retrieve_all_cashier_journals, query: mapped_keys(query))
    end

    class TellerCashiers < Resource
      def initialize(client, teller_id)
        super(client)
        @teller_id = id!(teller_id, "teller_id")
      end

      def list(**query)
        call(:retrieve_all_cashiers_for_teller, path: { tellerId: @teller_id }, query: mapped_keys(query))
      end

      def template = call(:retrieve_cashier_template_for_teller, path: { tellerId: @teller_id })

      def create(**attributes)
        validate_contract(Contracts::CashManagement::CashierCreate, attributes)
        call(:create_cashier_for_teller, path: { tellerId: @teller_id },
                                         body: mapped_keys(attributes, CashManagement::CASHIER_FIELDS), idempotent: false)
      rescue ValidationError => e
        Failure.new(e)
      end

      def retrieve(cashier_id) = call(:retrieve_one_cashier_for_teller, path: paths(cashier_id))

      def update(cashier_id, **attributes)
        call(:update_cashier_for_teller, path: paths(cashier_id),
                                         body: mapped_keys(attributes, CashManagement::CASHIER_FIELDS), idempotent: false)
      end

      def delete(cashier_id) = call(:delete_cashier_for_teller, path: paths(cashier_id), idempotent: false)
      def allocate(cashier_id, **attributes) = transaction(:allocate_cash_to_cashier, cashier_id, attributes)
      def settle(cashier_id, **attributes) = transaction(:settle_cash_from_cashier, cashier_id, attributes)

      def summary(cashier_id, **query)
        call(:retrieve_cashier_transactions_with_summary, path: paths(cashier_id), query: mapped_keys(query))
      end

      def transactions(cashier_id, **query)
        call(:retrieve_cashier_transactions, path: paths(cashier_id), query: mapped_keys(query))
      end

      def transaction_template(cashier_id) = call(:retrieve_template_cashier_transaction, path: paths(cashier_id))

      private

      def paths(cashier_id) = { tellerId: @teller_id, cashierId: id!(cashier_id, "cashier_id") }

      def transaction(operation, cashier_id, attributes)
        validate_contract(Contracts::CashManagement::CashTransaction, attributes)
        call(operation, path: paths(cashier_id), body: mapped_keys(attributes, CashManagement::TRANSACTION_FIELDS),
                        idempotent: false)
      rescue ValidationError => e
        Failure.new(e)
      end
    end

    attr_reader :cashier_journals

    def initialize(client)
      super
      @cashiers = Cashiers.new(client)
      @cashier_journals = CashierJournals.new(client)
    end

    def cashiers(teller_id = nil, **query)
      return unless teller_id

      TellerCashiers.new(client, teller_id).list(**query)
    end

    def cashiers_resource(teller_id) = TellerCashiers.new(client, teller_id)

    def list(**query) = call(:retrieve_all_tellers, query: mapped_keys(query))
    alias all list
    def create(**attributes)
      validate_contract(Contracts::CashManagement::TellerCreate, attributes)
      call(:create_teller, body: mapped_keys(attributes, TELLER_FIELDS), idempotent: false)
    rescue ValidationError => e
      Failure.new(e)
    end

    def retrieve(teller_id) = call(:retrieve_one_teller, path: teller_path(teller_id))

    def update(teller_id, **attributes)
      call(:update_teller, path: teller_path(teller_id), body: mapped_keys(attributes, TELLER_FIELDS),
                           idempotent: false)
    end

    def delete(teller_id) = call(:delete_teller, path: teller_path(teller_id), idempotent: false)

    def journals(teller_id, **query)
      call(:retrieve_all_journals_for_teller, path: teller_path(teller_id), query: mapped_keys(query))
    end

    def transactions(teller_id, **query)
      call(:retrieve_all_transactions_for_teller, path: teller_path(teller_id), query: mapped_keys(query))
    end

    def transaction(teller_id, transaction_id)
      call(:retrieve_one_transaction_for_teller,
           path: teller_path(teller_id).merge(transactionId: id!(transaction_id, "transaction_id")))
    end

    private

    def teller_path(teller_id) = { tellerId: id!(teller_id, "teller_id") }
  end
end
