# frozen_string_literal: true

module Fineract
  class Clients
    class Templates < Resource
      def retrieve = call(:retrieve_template_client)
      def download(**query) = call(:get_client_template, query: mapped_keys(query), response_type: :binary)
      def upload(uploaded_input_stream:, locale: nil, date_format: nil) = call(:post_client_template, body: { "uploadedInputStream" => uploaded_input_stream, "locale" => locale, "dateFormat" => date_format }.compact, request_type: "multipart/form-data", idempotent: false)
    end
    class Accounts < Resource
      def list(client_id, **query) = safe_call { call(:retrieve_all_client_accounts, path: { clientId: id!(client_id, "client_id") }, query: mapped_keys(query)) }
      alias overview list
    end
    class Identifiers < Resource
      def list(id, **query) = call(:retrieve_all_client_identifiers, path: { clientId: id!(id, "client_id") }, query: mapped_keys(query))
      def template(id) = call(:retrieve_template_client_identifier, path: { clientId: id!(id, "client_id") })
      def create(id, **attrs) = call(:create_client_identifier, path: { clientId: id!(id, "client_id") }, body: mapped_keys(attrs, document_type_id: "documentTypeId", document_key: "documentKey", description: "description"), idempotent: false)
      def retrieve(id, identifier_id) = call(:retrieve_one_client_identifier, path: { clientId: id!(id, "client_id"), identifierId: id!(identifier_id, "identifier_id") })
      def update(id, identifier_id, **attrs) = call(:update_client_identifier, path: { clientId: id!(id, "client_id"), identifierId: id!(identifier_id, "identifier_id") }, body: mapped_keys(attrs), idempotent: false)
      def delete(id, identifier_id) = call(:delete_client_identifier, path: { clientId: id!(id, "client_id"), identifierId: id!(identifier_id, "identifier_id") }, idempotent: false)
    end
    class Charges < Resource
      def list(id, **query) = call(:retrieve_all_client_charges, path: { clientId: id!(id, "client_id") }, query: mapped_keys(query))
      def template(id) = call(:retrieve_template_client_charge, path: { clientId: id!(id, "client_id") })
      def create(id, **attrs) = call(:create_client_charge, path: { clientId: id!(id, "client_id") }, body: mapped_keys(attrs, charge_id: "chargeId", due_date: "dueDate", date_format: "dateFormat"), idempotent: false)
      def retrieve(id, charge_id) = call(:retrieve_one_client_charge, path: { clientId: id!(id, "client_id"), chargeId: id!(charge_id, "charge_id") })
      def pay_or_waive(id, charge_id, command:, **attrs) = call(:pay_or_waive_client_charge, path: { clientId: id!(id, "client_id"), chargeId: id!(charge_id, "charge_id") }, query: { "command" => command }, body: mapped_keys(attrs), idempotent: false)
      def delete(id, charge_id) = call(:delete_client_charge, path: { clientId: id!(id, "client_id"), chargeId: id!(charge_id, "charge_id") }, idempotent: false)
    end
    class Transactions < Resource
      def list(id, **query) = call(:retrieve_all_client_transactions, path: { clientId: id!(id, "client_id") }, query: mapped_keys(query))
      def retrieve(id, transaction_id) = call(:retrieve_client_transaction, path: { clientId: id!(id, "client_id"), transactionId: id!(transaction_id, "transaction_id") })
      def undo(id, transaction_id, **attrs) = call(:undo_client_transaction, path: { clientId: id!(id, "client_id"), transactionId: id!(transaction_id, "transaction_id") }, body: mapped_keys(attrs), idempotent: false)
    end
    class Notes < Resource
      def list(id, resource_type: "clients", **query) = call(:retrieve_notes_by_resource, path: { resourceType: resource_type, resourceId: id!(id, "resource_id") }, query: mapped_keys(query))
      def create(id, note:, resource_type: "clients") = call(:add_new_note, path: { resourceType: resource_type, resourceId: id!(id, "resource_id") }, body: { "note" => note }, idempotent: false)
      def retrieve(id, note_id, resource_type: "clients") = call(:retrieve_note, path: { resourceType: resource_type, resourceId: id!(id, "resource_id"), noteId: id!(note_id, "note_id") })
      def update(id, note_id, note:, resource_type: "clients") = call(:update_note, path: { resourceType: resource_type, resourceId: id!(id, "resource_id"), noteId: id!(note_id, "note_id") }, body: { "note" => note }, idempotent: false)
      def delete(id, note_id, resource_type: "clients") = call(:delete_note, path: { resourceType: resource_type, resourceId: id!(id, "resource_id"), noteId: id!(note_id, "note_id") }, idempotent: false)
    end
    class Documents < Resource
      def list(id) = call(:retrieve_all_documents, path: { entityType: "clients", entityId: id!(id, "client_id") })
      def create(id, file:, name: nil, description: nil) = call(:create_document, path: { entityType: "clients", entityId: id!(id, "client_id") }, body: { "file" => file, "name" => name, "description" => description }.compact, request_type: "multipart/form-data", idempotent: false)
      def retrieve(id, document_id) = call(:get_document, path: { entityType: "clients", entityId: id!(id, "client_id"), documentId: id!(document_id, "document_id") })
      def download(id, document_id) = call(:download_file, path: { entityType: "clients", entityId: id!(id, "client_id"), documentId: id!(document_id, "document_id") }, response_type: :binary)
      def delete(id, document_id) = call(:delete_document, path: { entityType: "clients", entityId: id!(id, "client_id"), documentId: id!(document_id, "document_id") }, idempotent: false)
    end
    class Images < Resource
      def retrieve(id) = call(:retrieve_image, path: { entityType: "clients", entityId: id!(id, "client_id") }, response_type: :binary)
      def create(id, image:) = call(:create_image_1, path: { entityType: "clients", entityId: id!(id, "client_id") }, body: { "file" => image }, request_type: "multipart/form-data", idempotent: false)
      def update(id, image:) = call(:update_image_1, path: { entityType: "clients", entityId: id!(id, "client_id") }, body: { "file" => image }, request_type: "multipart/form-data", idempotent: false)
      def delete(id) = call(:delete_image, path: { entityType: "clients", entityId: id!(id, "client_id") }, idempotent: false)
    end
    class Datatables < Resource
      def list = call(:get_datatables)
      def retrieve(datatable) = call(:get_datatable, path: { datatable: datatable.to_s })
      def query(datatable, **params) = call(:query_values, path: { datatable: datatable.to_s }, query: mapped_keys(params))
      def advanced_query(datatable, **attributes) = call(:advanced_query, path: { datatable: datatable.to_s }, body: mapped_keys(attributes), idempotent: false)
      def create(datatable, application_table_name:, **attributes) = call(:create_datatable_entry, path: { datatable: datatable.to_s, apptableId: application_table_name }, body: mapped_keys(attributes), idempotent: false)
      def update(datatable, application_table_id, **attributes) = call(:update_datatable_entry_oneto_one, path: { datatable: datatable.to_s, apptableId: application_table_id }, body: mapped_keys(attributes), idempotent: false)
      def delete(datatable, application_table_id) = call(:delete_datatable_entries, path: { datatable: datatable.to_s, apptableId: application_table_id }, idempotent: false)
    end
    attr_reader :templates, :identifiers, :charges, :transactions, :notes, :documents, :images, :datatables
    def accounts(client_id = nil, **query) = client_id ? @accounts.list(client_id, **query) : @accounts
    alias account_overviews accounts
    def initialize(client)
      super
      @addresses = Addresses.new(client); @lifecycle = Lifecycle.new(client); @transfers = Transfers.new(client)
      @templates = Templates.new(client); @accounts = Accounts.new(client)
      @identifiers = Identifiers.new(client); @charges = Charges.new(client); @transactions = Transactions.new(client)
      @notes = Notes.new(client); @documents = Documents.new(client); @images = Images.new(client); @datatables = Datatables.new(client)
    end
  end
end
