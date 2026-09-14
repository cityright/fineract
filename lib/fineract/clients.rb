# frozen_string_literal: true

module Fineract
  class Clients < Resource
    CLIENT_FIELDS = { firstname: "firstname", lastname: "lastname", office_id: "officeId", active: "active", activation_date: "activationDate", date_format: "dateFormat", locale: "locale", mobile_no: "mobileNo", external_id: "externalId", legal_form_id: "legalFormId", savings_product_id: "savingsProductId", submitted_on_date: "submittedOnDate", staff_id: "staffId", gender_id: "genderId", client_type_id: "clientTypeId", client_classification_id: "clientClassificationId", date_of_birth: "dateOfBirth", image_id: "imageId", middle_name: "middlename", email: "email" }.freeze
    ADDRESS_FIELDS = { address_type_id: "addressTypeId", street: "street", address_line1: "addressLine1", address_line2: "addressLine2", address_line3: "addressLine3", city: "city", state_province_id: "stateProvinceId", country_id: "countryId", postal_code: "postalCode" }.freeze
    COMMAND_FIELDS = { activation_date: "activationDate", closure_date: "closureDate", rejection_date: "rejectionDate", withdrawal_date: "withdrawalDate", reopened_date: "reopenedDate", rejection_reason_id: "rejectionReasonId", withdrawal_reason_id: "withdrawalReasonId", savings_account_id: "savingsAccountId", destination_office_id: "destinationOfficeId", destination_group_id: "destinationGroupId", staff_id: "staffId", note: "note", date_format: "dateFormat", locale: "locale", transfer_date: "transferDate" }.freeze

    class Addresses < Resource
      def list(client_id, status: nil, type: nil) = safe_call { call(:retrieve_all_client_addresses, path: { clientid: id!(client_id, "client_id") }, query: { "status" => status, "type" => type }.compact) }
      def create(client_id, type: nil, **attributes) = safe_call { call(:create_client_address, path: { clientid: id!(client_id, "client_id") }, query: { "type" => type }.compact, body: mapped_keys(attributes, Clients::ADDRESS_FIELDS)) }
      def update(client_id, **attributes) = safe_call { call(:update_client_address, path: { clientid: id!(client_id, "client_id") }, body: mapped_keys(attributes, Clients::ADDRESS_FIELDS)) }
    end

    class Lifecycle < Resource
      %i[activate close reactivate reject withdraw undo_reject undo_withdraw].each do |operation|
        define_method(operation) { |client_id, **attributes| Clients.new(client).public_send(operation, client_id, **attributes) }
      end
    end

    class Transfers < Resource
      %i[propose_transfer accept_transfer reject_transfer withdraw_transfer propose_and_accept_transfer].each do |operation|
        define_method(operation) { |client_id, **attributes| Clients.new(client).public_send(operation, client_id, **attributes) }
      end
    end

    attr_reader :addresses, :lifecycle, :transfers
    def list(**filters) = call(:retrieve_all_clients, query: mapped_keys(filters, office_id: "officeId", external_id: "externalId", display_name: "displayName", first_name: "firstName", last_name: "lastName", under_hierarchy: "underHierarchy", order_by: "orderBy", sort_order: "sortOrder", orphans_only: "orphansOnly", legal_form: "legalForm", staff_id: "staffId"))
    def create(**attributes)
      validate_contract(Contracts::PhaseOne::ClientCreate, attributes)
      call(:create_client, body: mapped_keys(attributes, CLIENT_FIELDS))
    rescue ValidationError => e
      Failure.new(e)
    end
    def retrieve(client_id, staff_in_selected_office_only: nil) = safe_call { call(:retrieve_one_client, path: { clientId: id!(client_id, "client_id") }, query: { "staffInSelectedOfficeOnly" => staff_in_selected_office_only }.compact) }
    def update(client_id, **attributes) = safe_call { call(:update_client, path: { clientId: id!(client_id, "client_id") }, body: mapped_keys(attributes, CLIENT_FIELDS)) }
    def delete(client_id) = safe_call { call(:delete_client, path: { clientId: id!(client_id, "client_id") }) }
    def accounts(client_id) = safe_call { call(:retrieve_all_client_accounts, path: { clientId: id!(client_id, "client_id") }) }
    def field_configuration(entity) = call(:get_addresses, path: { entity: entity.to_s })
    def activate(client_id, **attributes) = command(client_id, "activate", attributes)
    def close(client_id, **attributes) = command(client_id, "close", attributes)
    def reactivate(client_id, **attributes) = command(client_id, "reactivate", attributes)
    def reject(client_id, **attributes) = command(client_id, "reject", attributes)
    def withdraw(client_id, **attributes) = command(client_id, "withdraw", attributes)
    def undo_reject(client_id, **attributes) = command(client_id, "UndoRejection", attributes)
    def undo_withdraw(client_id, **attributes) = command(client_id, "UndoWithdrawal", attributes)
    def assign_staff(client_id, staff_id:) = command(client_id, "assignStaff", { staff_id: staff_id })
    def unassign_staff(client_id, staff_id:) = command(client_id, "unassignStaff", { staff_id: staff_id })
    def update_savings_account(client_id, savings_account_id:) = command(client_id, "updateSavingsAccount", { savings_account_id: savings_account_id })
    def propose_transfer(client_id, **attributes) = command(client_id, "proposeTransfer", attributes)
    def accept_transfer(client_id, **attributes) = command(client_id, "acceptTransfer", attributes)
    def reject_transfer(client_id, **attributes) = command(client_id, "rejectTransfer", attributes)
    def withdraw_transfer(client_id, **attributes) = command(client_id, "withdrawTransfer", attributes)
    def propose_and_accept_transfer(client_id, **attributes) = command(client_id, "proposeAndAcceptTransfer", attributes)
    def initialize(client)
      super
      @addresses = Addresses.new(client)
      @lifecycle = Lifecycle.new(client)
      @transfers = Transfers.new(client)
    end

    private
    def validate_contract(contract, attributes)
      result = contract.new.call(attributes)
      raise ValidationError, result.errors.to_h.inspect unless result.success?
    end
    def command(client_id, command_name, attributes) = safe_call { call(:handle_command_client, path: { clientId: id!(client_id, "client_id") }, query: { "command" => command_name }, body: mapped_keys(attributes, COMMAND_FIELDS)) }
  end
end
