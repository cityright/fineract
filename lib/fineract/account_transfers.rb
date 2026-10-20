# frozen_string_literal: true

module Fineract
  class AccountTransfers < Resource
    FIELDS = Shares::TRANSFER_FIELDS
    def list = call(:retrieve_all_account_transfers)

    def create(**attributes)
      validate_contract(Contracts::PhaseOne::AccountTransferCreate, attributes)
      call(:create_account_transfer, body: mapped_keys(attributes, FIELDS), idempotent: false)
    rescue ValidationError => e then Failure.new(e)
    end

    def retrieve(transfer_id)
      safe_call { call(:retrieve_one_account_transfer, path: { transferId: id!(transfer_id, "transfer_id") }) }
    end

    def command(transfer_id, command:)
      safe_call do
        call(:account_transfer_operation, path: { accountTransferId: id!(transfer_id, "transfer_id") },
                                          query: { "command" => command }, idempotent: false)
      end
    end

    def refund(**attributes) = call(:refund_by_transfer, body: mapped_keys(attributes, FIELDS), idempotent: false)
    def template(**query) = call(:retrieve_template_account_transfer, query: mapped_keys(query, FIELDS))
    def refund_template(**query) = call(:retrieve_template_refund_by_transfer, query: mapped_keys(query, FIELDS))
  end
end
