# frozen_string_literal: true

# rubocop:disable all

module Fineract
  # Loan extensions and specialist lending APIs from the 1.15.0 contract.
  module LendingSupport
    private

    def path_id(value, name) = id!(value, name)
  end

  class LoanCollaterals < Resource
    def list(loan_id) = safe_call { call(:retrieve_collateral_details, path: { loanId: id!(loan_id, "loan_id") }) }
    def template(loan_id) = safe_call { call(:new_collateral_template, path: { loanId: id!(loan_id, "loan_id") }) }
    def create(loan_id, **attributes) = safe_call { call(:create_collateral, path: { loanId: id!(loan_id, "loan_id") }, body: mapped_keys(attributes), idempotent: false) }
    def retrieve(loan_id, collateral_id) = safe_call { call(:retrieve_collateral_details_1, path: { loanId: id!(loan_id, "loan_id"), collateralId: id!(collateral_id, "collateral_id") }) }
    def update(loan_id, collateral_id, **attributes) = safe_call { call(:update_collateral, path: { loanId: id!(loan_id, "loan_id"), collateralId: id!(collateral_id, "collateral_id") }, body: mapped_keys(attributes), idempotent: false) }
    def delete(loan_id, collateral_id) = safe_call { call(:delete_collateral, path: { loanId: id!(loan_id, "loan_id"), collateralId: id!(collateral_id, "collateral_id") }, idempotent: false) }
  end

  class LoanGuarantors < Resource
    def list(loan_id) = safe_call { call(:retrieve_guarantor_details, path: { loanId: id!(loan_id, "loan_id") }) }
    def template(loan_id) = safe_call { call(:new_guarantor_template, path: { loanId: id!(loan_id, "loan_id") }) }
    def accounts_template(loan_id) = safe_call { call(:accounts_template, path: { loanId: id!(loan_id, "loan_id") }) }
    def download_template(loan_id) = safe_call { call(:get_guarantor_template, path: { loanId: id!(loan_id, "loan_id") }, response_type: :binary) }
    def upload_template(loan_id, uploaded_input_stream:, locale: nil, date_format: nil) = safe_call { call(:post_guarantor_template, path: { loanId: id!(loan_id, "loan_id") }, body: { "uploadedInputStream" => uploaded_input_stream, "locale" => locale, "dateFormat" => date_format }.compact, request_type: "multipart/form-data", idempotent: false) }
    def create(loan_id, **attributes) = safe_call { call(:create_guarantor, path: { loanId: id!(loan_id, "loan_id") }, body: mapped_keys(attributes), idempotent: false) }
    def retrieve(loan_id, guarantor_id) = safe_call { call(:retrieve_guarantor_details_1, path: { loanId: id!(loan_id, "loan_id"), guarantorId: id!(guarantor_id, "guarantor_id") }) }
    def update(loan_id, guarantor_id, **attributes) = safe_call { call(:update_guarantor, path: { loanId: id!(loan_id, "loan_id"), guarantorId: id!(guarantor_id, "guarantor_id") }, body: mapped_keys(attributes), idempotent: false) }
    def delete(loan_id, guarantor_id) = safe_call { call(:delete_guarantor, path: { loanId: id!(loan_id, "loan_id"), guarantorId: id!(guarantor_id, "guarantor_id") }, idempotent: false) }
  end

  class PostDatedChecks < Resource
    def list(loan_id) = safe_call { call(:get_post_dated_checks, path: { loanId: id!(loan_id, "loan_id") }) }
    def retrieve(loan_id, installment_id) = safe_call { call(:get_post_dated_check, path: { loanId: id!(loan_id, "loan_id"), installmentId: id!(installment_id, "installment_id") }) }
    def update(loan_id, check_id, edit_type: nil, **attributes) = safe_call { call(:update_post_dated_checks, path: { loanId: id!(loan_id, "loan_id"), postDatedCheckId: id!(check_id, "post_dated_check_id") }, query: { "editType" => edit_type }.compact, body: mapped_keys(attributes), idempotent: false) }
    def delete(loan_id, check_id) = safe_call { call(:delete_post_dated_check, path: { loanId: id!(loan_id, "loan_id"), postDatedCheckId: id!(check_id, "post_dated_check_id") }, idempotent: false) }
  end

  class ClientCollaterals < Resource
    def list(client_id, product_id: nil) = safe_call { call(:get_client_collateral_products, path: { clientId: id!(client_id, "client_id") }, query: { "prodId" => product_id }.compact) }
    def template(client_id) = safe_call { call(:get_client_collateral_template, path: { clientId: id!(client_id, "client_id") }) }
    def create(client_id, **attributes) = safe_call { call(:add_client_collateral, path: { clientId: id!(client_id, "client_id") }, body: mapped_keys(attributes), idempotent: false) }
    def retrieve(client_id, collateral_id) = safe_call { call(:get_client_collateral_data, path: { clientId: id!(client_id, "client_id"), clientCollateralId: id!(collateral_id, "collateral_id") }) }
    def update(client_id, collateral_id, **attributes) = safe_call { call(:update_client_collateral, path: { clientId: id!(client_id, "client_id"), collateralId: id!(collateral_id, "collateral_id") }, body: mapped_keys(attributes), idempotent: false) }
    def delete(client_id, collateral_id) = safe_call { call(:delete_client_collateral, path: { clientId: id!(client_id, "client_id"), collateralId: id!(collateral_id, "collateral_id") }, idempotent: false) }
  end

  class CollateralManagement < Resource
    def list(**query) = call(:get_all_collaterals, query: mapped_keys(query))
    def template = call(:get_collateral_template)
    def create(**attributes) = call(:create_collateral_1, body: mapped_keys(attributes), idempotent: false)
    def retrieve(id) = safe_call { call(:get_collateral, path: { collateralId: id!(id, "collateral_id") }) }
    def update(id, **attributes) = safe_call { call(:update_collateral_1, path: { collateralId: id!(id, "collateral_id") }, body: mapped_keys(attributes), idempotent: false) }
    def delete(id) = safe_call { call(:delete_collateral_1, path: { collateralId: id!(id, "collateral_id") }, idempotent: false) }
  end

  class CreditBureau < Resource
    def list(**query) = call(:get_credit_bureau, query: mapped_keys(query))
    def create(credit_bureau_id, **attributes) = call(:create_credit_bureau_configuration, path: { creditBureauId: id!(credit_bureau_id, "credit_bureau_id") }, body: mapped_keys(attributes), idempotent: false)
    def retrieve_configuration(id) = call(:get_configuration, path: { organisationCreditBureauId: id!(id, "organisation_credit_bureau_id") })
    def update_configuration(id, **attributes) = call(:update_credit_bureau_configuration, path: { configurationId: id!(id, "configuration_id") }, body: mapped_keys(attributes), idempotent: false)
    def mappings(**query) = call(:get_credit_bureau_loan_product_mapping, query: mapped_keys(query))
    def create_mapping(id, **attributes) = call(:create_credit_bureau_loan_product_mapping, path: { organisationCreditBureauId: id!(id, "organisation_credit_bureau_id") }, body: mapped_keys(attributes), idempotent: false)
    def update_mapping(**attributes) = call(:update_credit_bureau_loan_product_mapping, body: mapped_keys(attributes), idempotent: false)
    def reports = Reports.new(client)
    class Reports < Resource
      def add(credit_bureau_id: nil, uploaded_input_stream:, locale: nil, date_format: nil) = call(:add_credit_report, query: { "creditBureauId" => credit_bureau_id }.compact, body: { "uploadedInputStream" => uploaded_input_stream, "locale" => locale, "dateFormat" => date_format }.compact, request_type: "multipart/form-data", idempotent: false)
      def fetch(**attributes) = call(:fetch_credit_report, body: mapped_keys(attributes), idempotent: false)
      def save(**attributes) = call(:save_credit_report, body: mapped_keys(attributes), idempotent: false)
      def retrieve(id) = call(:get_saved_credit_report, path: { creditBureauId: id!(id, "credit_bureau_id") })
      def delete(id) = call(:delete_credit_report, path: { creditBureauId: id!(id, "credit_bureau_id") }, idempotent: false)
    end
  end
end
# rubocop:enable all
