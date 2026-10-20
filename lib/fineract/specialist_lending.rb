# frozen_string_literal: true

# rubocop:disable all

module Fineract
  class Glim < Resource
    def group_accounts(group_id) = call(:retrieve_glim_accounts_group, path: { groupId: id!(group_id, "group_id") })
    def repayment_template(glim_id) = call(:get_glim_repayment_template, path: { glimId: id!(glim_id, "glim_id") })
    def command(glim_id, command:, **attributes) = call(:handle_commands_glim_loan, path: { glimId: id!(glim_id, "glim_id") }, query: { "command" => command }, body: mapped_keys(attributes), idempotent: false)
  end

  class Gsim < Resource
    def submit(**attributes) = call(:submit_gsim_application, body: mapped_keys(attributes), idempotent: false)
    def update(parent_account_id, **attributes) = call(:update_gsim, path: { parentAccountId: id!(parent_account_id, "parent_account_id") }, body: mapped_keys(attributes), idempotent: false)
    def command(parent_account_id, command:, **attributes) = call(:handle_gsim_commands, path: { parentAccountId: id!(parent_account_id, "parent_account_id") }, query: { "command" => command }, body: mapped_keys(attributes), idempotent: false)
  end

  class ExternalAssetOwners < Resource
    def list(**query) = call(:retrieve_external_asset_owners, query: mapped_keys(query))
    def search(**attributes) = call(:search_investor_data, body: mapped_keys(attributes), idempotent: false)
    def create(**attributes) = call(:create_external_asset_owner, body: mapped_keys(attributes), idempotent: false)
    def transfers(**query) = call(:get_transfers, query: mapped_keys(query))
    def active_transfer = call(:get_active_transfer)
    def transfer(id: nil, loan_id: nil, external_id: nil, loan_external_id: nil, **attributes)
      operation, path = if loan_id
                         [:transfer_request_with_loan_id, { loanId: id!(loan_id, "loan_id") }]
                       elsif loan_external_id
                         [:transfer_request_with_loan_external_id, { loanExternalId: loan_external_id }]
                       elsif external_id
                         [:transfer_request_with_id_by_external_id, { externalId: external_id }]
                       else
                         [:transfer_request_with_id, { id: id!(id, "transfer_id") }]
                       end
      call(operation, path: path, body: mapped_keys(attributes), idempotent: false)
    end
  end

  class WorkingCapitalLoanProducts < Resource
    def list(**query) = call(:retrieve_all_working_capital_loan_products, query: mapped_keys(query))
    def template = call(:retrieve_template_working_capital_loan_product)
    def create(**attributes) = call(:create_working_capital_loan_product, body: mapped_keys(attributes), idempotent: false)
    def retrieve(id) = call(:retrieve_one_working_capital_loan_product, path: { productId: id!(id, "product_id") })
    def update(id, **attributes) = call(:update_working_capital_loan_product, path: { productId: id!(id, "product_id") }, body: mapped_keys(attributes), idempotent: false)
    def delete(id) = call(:delete_working_capital_loan_product, path: { productId: id!(id, "product_id") }, idempotent: false)
  end

  class WorkingCapitalLoans < Resource
    def list(**query) = call(:retrieve_all_working_capital_loans, query: mapped_keys(query))
    def template = call(:retrieve_working_capital_loan_template)
    def submit(**attributes) = call(:submit_working_capital_loan_application, body: mapped_keys(attributes), idempotent: false)
    def retrieve(id) = call(:retrieve_working_capital_loan_by_id, path: { loanId: id!(id, "loan_id") })
    def update(id, **attributes) = call(:modify_working_capital_loan_application_by_id, path: { loanId: id!(id, "loan_id") }, body: mapped_keys(attributes), idempotent: false)
    def delete(id) = call(:delete_working_capital_loan_application, path: { loanId: id!(id, "loan_id") }, idempotent: false)
    def command(id, command:, **attributes) = call(:state_transition_working_capital_loan_by_id, path: { loanId: id!(id, "loan_id") }, query: { "command" => command }, body: mapped_keys(attributes), idempotent: false)
    def schedule(id) = call(:retrieve_amortization_schedule, path: { loanId: id!(id, "loan_id") })
    def rate_changes(id) = call(:get_working_capital_loan_rate_change_history_by_id, path: { loanId: id!(id, "loan_id") })
  end
end
# rubocop:enable all
